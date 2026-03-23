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

/** Microsoft.Tiwari Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Tiwari" })
@versioned(Microsoft.Tiwari.Versions)
namespace Microsoft.Tiwari;

/** The available API versions. */
enum Versions {
  /** 2024-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_01_01_preview: "2024-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

/** A Tiwari resource */
model TiwariResource is TrackedResource<TiwariProperties> {
  ...ResourceNameParameter<TiwariResource>;
}

/** Tiwari resource properties */
model TiwariProperties {
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
interface TiwariResources {
  get is ArmResourceRead<TiwariResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TiwariResource>;
  delete is ArmResourceDeleteWithoutOkAsync<TiwariResource>;
  listByResourceGroup is ArmResourceListByParent<TiwariResource>;
  listBySubscription is ArmListBySubscription<TiwariResource>;
}
