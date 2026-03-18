import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Barbie Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Barbie" })
@versioned(Microsoft.Barbie.Versions)
namespace Microsoft.Barbie;

/** The available API versions. */
enum Versions {
  /** 2024-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_01_01_preview: "2024-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

/** A Barbie resource */
model BarbieResource is TrackedResource<BarbieProperties> {
  ...ResourceNameParameter<BarbieResource>;
}

/** Barbie resource properties */
model BarbieProperties {
  /** Display name */
  displayName?: string;

  /** The provisioning state */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  string,
}

@armResourceOperations
interface BarbieResources {
  get is ArmResourceRead<BarbieResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BarbieResource>;
  delete is ArmResourceDeleteWithoutOkAsync<BarbieResource>;
  listByResourceGroup is ArmResourceListByParent<BarbieResource>;
  listBySubscription is ArmListBySubscription<BarbieResource>;
}
