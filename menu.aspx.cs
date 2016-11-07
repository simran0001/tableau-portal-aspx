using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProPortal_Portal
{
    public partial class menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // ###########################################################
        // The load_menu() function takes both the user_id that is 
        // currently logged in and the json_string that has all of the
        // workbooks in it.  The result is the menu that is displayed
        // in the page.
        public string load_menu(string json_string, string user_id)
        {
            string result = "";
            int my_cnt = 0;
            string last_group = "";

            // ###########################################################
            // Here we Deserialize the JSON array into a DataTable of 
            // workbooks called my_workbooks
            DataTable my_workbooks = (DataTable)JsonConvert.DeserializeObject(json_string, (typeof(DataTable)));

            // ###########################################################
            // We go through each row of the my_workbooks array and process
            // each row.
            foreach (DataRow row in my_workbooks.Rows)
            {
                string group_name = row["project_name"].ToString();
                string report_id = row["id"].ToString();
                string workbook_name = row["name"].ToString();

                // ###########################################################
                // If this workbook is in the same group_name as the last one
                // then we display different HTML than if this was the first 
                // item from a new group.
                if (group_name == last_group)
                {
                    result = result + "</div></div></div>";
                    result = result + "<div style='clear: both;'></div>";
                    result = result + "<div style='padding: 10px;'>";
                    result = result + "<div class='col-md-2'>";

                    // We are not using thumb nail images for this example
                    //result = result + "<img src='/_imgs/_ugc/" + user_id + "_" + report_id + ".png'>";

                    result = result + "</div>";
                    result = result + "<div class='col-md-8' style='padding-left: 40px;'>";
                    result = result + "<div style='font-size: 16px;'>";
                    // ###########################################################
                    // The link to the report view page simply adds the report_id
                    // to the end.
                    result = result + "<a href='report_view.aspx?report_id=" + report_id + "' style='font-size: 28px;'>" + workbook_name + "</a><br/>";
                    result = result + "</div></div>";
                    result = result + "<div class='col-md-1' style=''>";
                    result = result + "<div>";
                    // ###########################################################
                    // The link to the report view page simply adds the report_id
                    // to the end.
                    result = result + "<input type='button' value='VIEW REPORT' class='btn btn-primary' onclick=\"location.href='report_view.aspx?report_id=" + report_id + "';\" style='width: 130px; margin-top: 10px;' />";
                }
                else
                {
                    // ###########################################################
                    // If this is the first workbook in the group, add the group
                    // 
                    if (my_cnt > 0)
                    {
                        result = result + "</div></div></div></div><hr class='featurette-divider'>";
                    }
                    my_cnt++;

                    result = result + "<div class='row featurette' style='padding-left: 15px; padding-bottom: 10px;'>";
                    result = result + "<div style='font-size: 24px;' >" + group_name + "</div>";
                    result = result + "<div style='padding: 10px;'>";
                    result = result + "<div class='col-md-2'>";

                    // We are not using thumb nail images for this example
                    //result = result + "<img src='/_imgs/_ugc/" + user_id + "_" + report_id + ".png'>";

                    result = result + "</div>";
                    result = result + "<div class='col-md-8' style='padding-left: 40px;'>";
                    result = result + "<div style='font-size: 16px;'>";
                    // ###########################################################
                    // The link to the report view page simply adds the report_id
                    // to the end.
                    result = result + "<a href='report_display.aspx?report_id=" + report_id + "' style='font-size: 28px;'>" + workbook_name + "</a><br/>";
                    result = result + "</div></div>";
                    result = result + "<div class='col-md-1' style=''>";
                    result = result + "<div>";
                    // ###########################################################
                    // The link to the report view page simply adds the report_id
                    // to the end.
                    result = result + "<input type='button' value='VIEW REPORT' class='btn btn-primary' onclick=\"location.href='report_view.aspx?report_id=" + report_id + "';\" style='width: 130px; margin-top: 10px;' />";

                    // ###########################################################
                    // Here we save the group_name to the last_group variable so that 
                    // the next loop will have the correct "previous group" saved
                    last_group = group_name;
                }
            }

            // ###########################################################
            // Return the HTML as a string.
            return result;
        }

    }
}