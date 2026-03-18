import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Batch;

/** Contains information about a schedule in a Batch account. */
@parentResource(BatchAccount)
model Schedule
  is Azure.ResourceManager.ProxyResource<ScheduleProperties> {
  ...ResourceNameParameter<
    Resource = Schedule,
    KeyName = "scheduleName",
    SegmentName = "schedules",
    NamePattern = "^[a-zA-Z0-9_-]+$"
  >;
}

/** Properties of a Batch schedule. */
model ScheduleProperties {
  /** Display name of the schedule. */
  displayName?: string;

  /** The recurrence interval in ISO 8601 duration format. */
  recurrenceInterval?: string;

  /** Whether the schedule is enabled. */
  enabled?: boolean;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;
}

@armResourceOperations
@tag("Schedule")
interface Schedules {
  /** Gets information about the specified schedule. */
  get is ArmResourceRead<Schedule, Error = CloudError>;

  /** Creates or updates a schedule. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Schedule, Error = CloudError>;

  /** Deletes the specified schedule. */
  delete is ArmResourceDeleteSync<Schedule, Error = CloudError>;

  /** Lists all schedules in the specified Batch account. */
  listByBatchAccount is ArmResourceListByParent<Schedule, Error = CloudError>;
}
