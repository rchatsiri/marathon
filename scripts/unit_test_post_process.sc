#!/usr/bin/env amm

import ammonite.ops._
import java.time.{ ZonedDateTime, ZoneId }
import scala.util.Properties
import scala.xml.XML

@main
def main(): Unit = {
  // Move coverage report to preserve it.
  mv(pwd/"target"/"scala-2.11"/"scoverage-report",
     pwd/"target"/"scala-2.11"/"scoverage-report-unit")
  mv(pwd/"target"/"scala-2.11"/"coverage-report"/"cobertura.xml",
     pwd/"target"/"scala-2.11"/"coverage-report"/"cobertura-unit.xml")

  // Convert Cobertura report to CSV.
  val projectName = Properties.envOrElse("JOB_NAME", "no_project_name_defined")
  val pipelineName = Properties.envOrElse("BRANCH_NAME", "no_pipeline_name_defined")
  val buildId = Properties.envOrElse("BUILD_ID", "no_build_id_definied")
  val buildTimestamp = ZonedDateTime.now(ZoneId.of("UTC")).toString

  val coverageXml = XML.loadFile("target/scala-2.11/scoverage-report-unit/scoverage.xml")

  val csvHeader = "project_name,pipeline_name,build_id,build_timestamp,package_name,class_name,class_file_name,statement_count,statements_invoked,statement_rate\n"
  val buildDetails = s"$projectName, $pipelineName, $buildId, $buildTimestamp"
  val csv: Seq[String] = csvHeader +: (coverageXml \\ "package").view.flatMap { p =>
    val packageName = p \@ "name"
    (p \ "classes" \ "class").map { c =>
      val className = c \@ "name"
      val classFileName = c \@ "filename"
      val statementCount = c \@ "statement-count"
      val statementsInvoked = c \@ "statements-invoked"
      val statementRate = c \@ "statement-rate"

      s"$buildDetails, $packageName, $className, $classFileName, $statementCount, $statementsInvoked, $statementRate\n"
    }
  }

  write.over(pwd/"target"/"scala-2.11"/"coverage-report"/"cobertura-unit.csv", csv)
}
