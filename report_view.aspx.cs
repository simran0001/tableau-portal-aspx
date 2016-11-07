using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using tableauREST9_v1;

namespace ProPortal_Portal
{
    public partial class report_view : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // do nothing
        }

        public string getReportString(string report_id, string trusted_ticket, string session_json)
        {
            string result = "";

            // ###########################################################
            // Here we grab the json string that is saved in the user
            // session manager and deserialize it into a DataTablea called
            // my_workbooks
            DataTable my_workbooks = (DataTable)JsonConvert.DeserializeObject(session_json, (typeof(DataTable)));

            // ###########################################################
            // now we loop through each of the rows in the DataTable
            // and process the results
            foreach (DataRow row in my_workbooks.Rows)
            {
                string group_name = row["project_name"].ToString();
                string my_report_id = row["id"].ToString();
                string workbook_name = row["name"].ToString();
                string default_view = row["default_view"].ToString();

                // ###########################################################
                // Here we replace any spaces with blanks
                default_view = default_view.Replace(" ", string.Empty);

                // ###########################################################
                // If the current row's report_id is equal to the report id that
                // was passed into the function, then we will construct the 
                // url using this workbooks information.
                if (my_report_id == report_id)
                {
                    // ###########################################################
                    // create the url here and place it into the result variable
                    result = "trusted/" + trusted_ticket + "/views/" + workbook_name + "/" + default_view;
                }
            }

            // ###########################################################
            // return the string that has the url for the workbook
            return result;
        }

        public string getTsTicket(string strURL, string user)
        {
            // ###########################################################
            // Take the URL and open a WebRequest with the handle "request"
            var request = (HttpWebRequest)WebRequest.Create(strURL);
            // ###########################################################
            // Here we pass the username as a POST variable
            var postData = "username="+user;
            // ###########################################################
            // turn the POST data into an ASCII string
            var data = Encoding.ASCII.GetBytes(postData);
            // ###########################################################
            // Set the request handle with the proper settings for this call
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;

            // ###########################################################
            // Here we add the POST data to the request stream
            using (var stream = request.GetRequestStream())
            {
                stream.Write(data, 0, data.Length);
            }

            // ###########################################################
            // Get the response from the trusted ticket call
            var response = (HttpWebResponse)request.GetResponse();
            var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();

            // ###########################################################
            // return the responseString that contains the trusted ticket
            // or an error message if the auth failed.
            return responseString;
        }

    }
}