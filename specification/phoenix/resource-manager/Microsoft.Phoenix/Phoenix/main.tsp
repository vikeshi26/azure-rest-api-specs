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

/** Microsoft.Phoenix Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Phoenix" })
@versioned(Microsoft.Phoenix.Versions)
namespace Microsoft.Phoenix;

/** The available API versions. */
enum Versions {
  /** 2024-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_01_01_preview: "2024-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

/** A Phoenix resource */
model PhoenixResource is TrackedResource<PhoenixProperties> {
  ...ResourceNameParameter<PhoenixResource>;
}

/** Phoenix resource properties */
model PhoenixProperties {
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
interface PhoenixResources {
  get is ArmResourceRead<PhoenixResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PhoenixResource>;
  delete is ArmResourceDeleteWithoutOkAsync<PhoenixResource>;
  listByResourceGroup is ArmResourceListByParent<PhoenixResource>;
  listBySubscription is ArmListBySubscription<PhoenixResource>;
}
