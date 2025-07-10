// this sample JavaScript code returns the value of important statistics for a given campaign, flow, form, or segment in the past year.
// for more information on the API, see https://developers.klaviyo.com/en/reference/reporting_api_overview

import { ApiKeySession, ReportingApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have read access to campaigns, flows, forms, and segments.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

const session = new ApiKeySession(apiKey)
const reportingApi = new ReportingApi(session)

// set the conversion metric ID. This example uses the same Placed Order metric ID for all examples. 
const conversionMetricId = 'conversion-metric-id' // replace with your actual conversion metric ID

// example 1: get open rate, click rate, conversion rate, and conversion value for a specific campaign in the last 30 days
const campaignTimeframe = 'last_30_days' // replace with your desired timeframe
const campaignPerformanceStatistics = ['open_rate','click_rate','conversion_rate','conversion_value'] // replace with your desired statistics
const campaignId = 'your-campaign-id' // replace with your actual campaign ID   

// set up the body of the Query Campaign Values request
const campaignPerformanceBody = {
    data: {
        type: "campaign-values-report",
        attributes: {
            timeframe: {
                key: campaignTimeframe,
            },
            statistics: campaignPerformanceStatistics,
            conversionMetricId: conversionMetricId,
            filter: `equals(campaign_id,'${campaignId}')`
        }
    }
}

// request campaign performance data
await reportingApi.queryCampaignValues(campaignPerformanceBody)
.then(response => {
    console.log('Campaign Performance:', response.data);
})
.catch(error => {
    console.error('Error fetching campaign performance:', error);
});

// example 2: get open rate, click rate, conversion rate, and conversion value for a specific flow in the last 12 months
const flowTimeframe = 'last_12_months' // replace with your desired timeframe
const flowPerformanceStatistics = ['open_rate','click_rate','conversion_rate','conversion_value'] // replace with your desired statistics
const flowId = 'your-flow-id' // replace with your actual flow ID

// set up the body of the Query Flow Values request
const flowPerformanceBody = {
    data: {
        type: "flow-values-report",
        attributes: {
            timeframe: {
                key: flowTimeframe,
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
    console.log('Flow Performance:', response.data);
})
.catch(error => {
    console.error('Error fetching flow performance:', error);
});

// example 3: get the number of form views, form submissions, and submit rate for a specific signup form in the last 30 days
const formId = 'your-form-id' // replace with your actual form ID
const formTimeframe = 'last_30_days' // replace with your desired timeframe
const formPerformanceStatistics = ['viewed_form','submits','submit_rate'] // replace with your desired statistics

// set up the body of the Query Form Values request
const formPerformanceBody = {
    data: {
        type: "form-values-report",
        attributes: {
            timeframe: {
                key: formTimeframe,
            },
            statistics: formPerformanceStatistics,
            filter: `equals(form_id,'${formId}')`
        }
    }
}

// request form performance data
await reportingApi.queryFormValues(formPerformanceBody)
.then(response => {
    console.log('Form Performance:', response.data);
})
.catch(error => {
    console.error('Error fetching form performance:', error);
});

// example 4: get number of members added to, removed from, and total members in a specific segment in the last 30 days
const segmentId = 'your-segment-id' // replace with your actual segment ID
const segmentTimeframe = 'last_30_days' // replace with your desired timeframe
const segmentPerformanceStatistics = ['members_added', 'members_removed', 'total_members'] // replace with your desired statistics

// set up the body of the Query Segment Series request
const segmentPerformanceBody = {
    data: {
        type: "segment-values-report",
        attributes: {
            timeframe: {
                key: segmentTimeframe,
            },
            statistics: segmentPerformanceStatistics,
            filter: `equals(segment_id,'${segmentId}')`
        }
    }
}   

// request segment performance data
await reportingApi.querySegmentValues(segmentPerformanceBody)
.then(response => {
    console.log('Segment Performance:', response.data);
})
.catch(error => {
    console.error('Error fetching segment performance:', error);
});
