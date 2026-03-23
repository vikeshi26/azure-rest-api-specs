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

/** Microsoft.Polarbear Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Polarbear" })
@versioned(Microsoft.Polarbear.Versions)
namespace Microsoft.Polarbear;

/** The available API versions. */
enum Versions {
  /** 2024-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_01_01_preview: "2024-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

/** A Polarbear resource */
model PolarbearResource is TrackedResource<PolarbearProperties> {
  ...ResourceNameParameter<PolarbearResource>;
}

/** Polarbear resource properties */
model PolarbearProperties {
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
interface PolarbearResources {
  get is ArmResourceRead<PolarbearResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PolarbearResource>;
  delete is ArmResourceDeleteWithoutOkAsync<PolarbearResource>;
  listByResourceGroup is ArmResourceListByParent<PolarbearResource>;
  listBySubscription is ArmListBySubscription<PolarbearResource>;
}
