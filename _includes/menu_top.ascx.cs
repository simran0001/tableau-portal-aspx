using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProPortal_Portal._includes
{
    public partial class menu_top : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string load_menu(string json_string)
        {
            string result = "";
            int my_cnt = 0;
            string last_group = "";

            DataTable my_workbooks = (DataTable)JsonConvert.DeserializeObject(json_string, (typeof(DataTable)));

            foreach (DataRow row in my_workbooks.Rows)
            {
                string group_name = row["project_name"].ToString();
                string report_id = row["id"].ToString();
                string name = row["name"].ToString();

                if (group_name == last_group)
                {
                    result = result + "<li><a href='#' onclick=\"location.href='/report_view.aspx?report_id=" + report_id + "';\">" + name + "</a></li>";
                }
                else
                {
                    if (my_cnt > 0)
                    {
                        result = result + "</ul></li>";
                    }
                    my_cnt++;

                    result = result + "<li class='dropdown'><a href='#' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-expanded='false'>" + group_name + "</a>";
                    result = result + "<ul class='dropdown-menu' role='menu'>";
                    result = result + "<li><a href='#' onclick=\"location.href='/report_view.aspx?report_id=" + report_id + "';\">" + name + "</a></li>";

                    last_group = group_name;
                }
            }

            return result;
        }


    }
}