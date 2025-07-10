// this sample JavaScript code gets flow-specific performance data related to an app metrics.
// for more information, see https://developers.klaviyo.com/en/docs/get_performance_data_for_flows_triggered_by_your_app_metrics 

import { ApiKeySession, ReportingApi, MetricsApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have read access to metrics and flows.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

const session = new ApiKeySession(apiKey)
const reportingApi = new ReportingApi(session)
const metricsApi = new MetricsApi(session)

/* Get flows triggered by your metric

To retrieve flow-specific performance data at the account level, we first need to identify which flows are triggered by your app's metrics within the account.

*/
const integrationName = 'your-integration-name' // replace with your actual integration name

// use the Get Metrics endpoint to fetch app metrics specific to your integration
const metricsList = await metricsApi.getMetrics({
    filter: `equals(integration.name,'${integrationName}')`,
    fieldsMetric: ['name','integration.id','integration.name']
})

// of the returned metrics, copy the metric ID(s) that you would like to use to fetch related flows.
// in this example, we will filter the response to use the metric ID for the "Placed Order" metric.
const placedOrderMetric = metricsList.body.data.find(metric => metric.attributes.name === 'Placed Order');
if (!placedOrderMetric) {
    throw new Error('Placed Order metric not found. Please check your integration name or metrics.');
}
const placedOrderMetricId = placedOrderMetric.id;

// then, use the Get IDs for Flows Triggered by App Metrics endpoint to fetch flows triggered by the "Placed Order" metric
const flowsTriggeredByMetric = await metricsApi.getFlowsTriggeredByMetric(placedOrderMetricId);

/* Fetch flow-specific performance data

Now that we have an ID for a flow that has been triggered by a specified app metric, we can fetch the performance data for that flow.
This example will query clicks, unique clicks, and unique conversions over a custom time frame, and then query clicks, delivery rate, and open rate on a weekly interval over the last 30 days.

*/

// first, use the Query Flow Values endpoint to query clicks, unique clicks, and unique conversions over a custom time frame
const conversionMetricId = 'your-conversion-metric-id' // replace with your actual conversion metric ID
const timeframeStart = '2025-01-01' // replace with your desired start date
const timeframeEnd = '2025-01-31' // replace with your desired end date
const flowPerformanceStatistics = ['clicks', 'clicks_unique', 'conversion_uniques'] // replace with your desired statistics

// get the flow ID from the flows triggered by the metric
const flowId = flowsTriggeredByMetric.body.data[0].id; // assuming we want the first flow in the list

// set up the body of the Query Flow Values request
const flowPerformanceBody = {
    data: {
        type: "flow-values-report",
        attributes: {
            timeframe: {
                start: timeframeStart,
                end: timeframeEnd
            },
            statistics: flowPerformanceStatistics,
            conversionMetricId: conversionMetricId,
            filter: `equals(flow_id,'${flowId}')`
        }
    }
}

// request flow performance data
await reportingApi.queryFlowValues(flowPerformanceBody)
.then(response => {
    console.log('Flow Performance', response.data);
})
.catch(error => {
    console.error('Error fetching flow performance:', error);
});

// next, use the Query Flow Series endpoint to query clicks, delivery rate, and open rate on a weekly interval over the last 30 days for the same flow.
const flowTimeframe = 'last_30_days' // replace with your desired timeframe
const weeklyFlowPerformanceStatistics = ['clicks', 'delivery_rate', 'open_rate'] // replace with your desired statistics
const flowReportInterval = 'weekly' // replace with your desired interval, e.g., 'daily', 'hourly', 'weekly', 'monthly'

// set up the body of the Query Flow Series request
const weeklyFlowPerformanceBody = {
    data: {
        type: "flow-series-report",
        attributes: {
            timeframe: {
                key: flowTimeframe,
            },
            interval: flowReportInterval,
            statistics: weeklyFlowPerformanceStatistics,
            filter: `equals(flow_id,'${flowId}')`,
            conversionMetricId: conversionMetricId
        }
    }
}

// request flow performance data
await reportingApi.queryFlowSeries(weeklyFlowPerformanceBody)
.then(response => {
    console.log('Flow Performance:', response.data);
})
.catch(error => {
    console.error('Error fetching flow performance:', error);
})