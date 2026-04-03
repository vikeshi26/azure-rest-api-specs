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

/** Microsoft.Batman Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Batman" })
@versioned(Microsoft.Batman.Versions)
namespace Microsoft.Batman;

/** The available API versions. */
enum Versions {
  /** 2024-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_01_01_preview: "2024-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

/** A Batman resource */
model BatmanResource is TrackedResource<BatmanProperties> {
  ...ResourceNameParameter<BatmanResource>;
}

/** Batman resource properties */
model BatmanProperties {
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
interface BatmanResources {
  get is ArmResourceRead<BatmanResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BatmanResource>;
  delete is ArmResourceDeleteWithoutOkAsync<BatmanResource>;
  listByResourceGroup is ArmResourceListByParent<BatmanResource>;
  listBySubscription is ArmListBySubscription<BatmanResource>;
}
