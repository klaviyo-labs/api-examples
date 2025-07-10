// this sample JavaScript code requests 1:1 matches of campaign, flow, form, and segment performance data shown in the Klaviyo app.
// for more information on the API, see https://developers.klaviyo.com/en/reference/reporting_api_overview

import { ApiKeySession, ReportingApi } from 'klaviyo-api'

// load private API key as an environment variable. Note that this API key needs to have read access to segment, campaigns, flows, and forms.
// if using a .env file, ensure to load it using dotenv or similar package. 
const apiKey = process.env.KLAVIYO_API_KEY
if (!apiKey) {
  throw new Error('Please set the KLAVIYO_API_KEY environment variable.')
}

const session = new ApiKeySession(apiKey)
const reportingApi = new ReportingApi(session)

// set the conversion metric ID. This example uses the same Placed Order metric ID for all examples. 
const conversionMetricId = 'conversion-metric-id' // replace with your actual conversion metric ID

// example 1: get open rate and click rate for campaigns in the last 30 days
const campaignTimeframe = 'last_30_days' // replace with your desired timeframe
const campaignPerformanceStatistics = ['open_rate','click_rate'] // replace with your desired statistics

// set up the body of the Query Campaign Values request
const campaignPerformanceBody = {
    data: {
        type: "campaign-values-report",
        attributes: {
            timeframe: {
                key: campaignTimeframe,
            },
            statistics: campaignPerformanceStatistics,
            conversionMetricId: conversionMetricId
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

// example 2: get conversion rate for SMS flows in the last 30 days
const flowTimeframe = 'last_30_days' // replace with your desired timeframe
const flowPerformanceStatistics = ['conversion_rate'] // replace with your desired statistics
const flowFilter = `equals(send_channel,'sms')` // filter for SMS flows (optional)

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
            filter: flowFilter
        }
    }
}

// request flow performance data
await reportingApi.queryFlowValues(flowPerformanceBody)
.then(response => {
    console.log('SMS flow Performance:', response.data);
})
.catch(error => {
    console.error('Error fetching SMS flow performance:', error);
});

// example 3: get weekly submit rate and number of form submits for all signup forms in the last 30 days
const formTimeframe = 'last_30_days' // replace with your desired timeframe
const formPerformanceStatistics = ['submit_rate', 'submits'] // replace with your desired statistics
const formReportInterval = 'weekly' // replace with your desired interval, e.g., 'daily', 'hourly', 'weekly', 'monthly'

// set up the body of the Query Form Series request
const formPerformanceBody = {
    data: {
        type: "form-series-report",
        attributes: {
            timeframe: {
                key: formTimeframe,
            },
            interval: formReportInterval,
            statistics: formPerformanceStatistics
        }
    }
}

// request form performance data
await reportingApi.queryFormSeries(formPerformanceBody)
.then(response => {
    console.log('Form Performance:', response.data);
})
.catch(error => {
    console.error('Error fetching form performance:', error);
});

// example 4: get number of members added to and removed from a specific segment every day this month
const segmentId = 'your-segment-id' // replace with your actual segment ID
const segmentTimeframe = 'this_month' // replace with your desired timeframe
const segmentPerformanceStatistics = ['members_added', 'members_removed'] // replace with your desired statistics
const segmentReportInterval = 'daily' // replace with your desired interval, e.g., 'daily', 'hourly', 'weekly', 'monthly'

// set up the body of the Query Segment Series request
const segmentPerformanceBody = {
    data: {
        type: "segment-series-report",
        attributes: {
            timeframe: {
                key: segmentTimeframe,
            },
            interval: segmentReportInterval,
            statistics: segmentPerformanceStatistics,
            filter: `equals(segment_id,'${segmentId}')`
        }
    }
}   

// request segment performance data
await reportingApi.querySegmentSeries(segmentPerformanceBody)
.then(response => {
    console.log('Segment Performance:', response.data);
})
.catch(error => {
    console.error('Error fetching segment performance:', error);
});
