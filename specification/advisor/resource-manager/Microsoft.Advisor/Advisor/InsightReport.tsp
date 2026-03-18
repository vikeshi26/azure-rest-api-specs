import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Advisor;

/** The Advisor insight report resource. */
@subscriptionResource
model InsightReport
  is Azure.ResourceManager.ProxyResource<InsightReportProperties> {
  ...ResourceNameParameter<
    Resource = InsightReport,
    KeyName = "reportName",
    SegmentName = "insightReports",
    NamePattern = ""
  >;
}

/** Properties of an insight report. */
model InsightReportProperties {
  /** Display name of the report */
  displayName?: string;

  /** Category of the insight */
  category?: string;

  /** The provisioning state */
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;
}

@armResourceOperations
interface InsightReports {
  /** Get an insight report by name. */
  get is ArmResourceRead<
    InsightReport,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /** List all insight reports. */
  list is ArmResourceListByParent<
    InsightReport,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}
