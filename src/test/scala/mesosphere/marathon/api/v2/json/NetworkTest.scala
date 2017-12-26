package mesosphere.marathon
package api.v2.json

<<<<<<< HEAD
import mesosphere.marathon.core.pod.ContainerNetwork
import mesosphere.{ UnitTest, ValidationTestLike }
import mesosphere.marathon.raml
import mesosphere.marathon.raml.Raml

class NetworkTest extends UnitTest with ValidationTestLike {
  val networkValidator = roundTripValidator[raml.Network](None)

  "it should not allow network names with special chars" in {
    val cn = Raml.toRaml(ContainerNetwork(name = "invalid^name"))

    networkValidator(cn) should haveViolations(
      "/name" -> "error.pattern")
  }

  "it should allow network names with underscores, numbers" in {
    val cn = Raml.toRaml(ContainerNetwork(name = "network_1-ops"))
    networkValidator(cn) shouldBe aSuccess
=======
import mesosphere.marathon.core.pod.{ ContainerNetwork, Network }
import mesosphere.{ UnitTest, ValidationTestLike }
import mesosphere.marathon.raml
import mesosphere.marathon.raml.Raml
import play.api.libs.json._

class NetworkTest extends UnitTest with ValidationTestLike {
  def toJsonAndBack(c: Network): Network = {
    Raml.fromRaml(
      Json.toJson(Raml.toRaml(c)).as[raml.Network])
  }

  "it should not allow network names with special chars" in {
    a[JsResultException] shouldBe thrownBy {
      toJsonAndBack(ContainerNetwork(name = "invalid^name"))
    }
  }

  "it should allow network names with underscores, numbers" in {
    val original = ContainerNetwork(name = "network_1-ops")
    toJsonAndBack(original) shouldBe original
>>>>>>> b926c88410a7b8cf0ddda4691372bae47ef80970
  }
}
