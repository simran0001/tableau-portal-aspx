using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using tableauREST9_v1;


namespace ProPortal_Portal._includes
{
    public partial class header : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // ###########################################################
        // tableau_load_profile checks user authentication and upon
        // success will return the user profile information.
        public ArrayList tableau_load_profile(string user_name, string user_pass)
        {
            // ###########################################################
            // setup the arraylist and variables that will be used in this function
            ArrayList results = new ArrayList();
            string ts_url = "http://localhost";
            string ugc_path = "c:\\inetpub\\wwwroot\\_imgs\\_ugc";
            string ts_path = "";
            string my_tok = "";
            string my_user_id = "";
            string my_site_id = "";
            string my_name = "";
            string my_site_role = "";
            string my_last_login = "";
            string my_full_name = "";
            string my_workbooks = "";

            // ###########################################################
            // First, start the controller which starts the DataPainters
            // REST API library.  This handles the REST API communication
            // and allows us to use simple function calls instead of writing
            // RAW REST communications for each call.
            tableau_controller tc = new tableau_controller(ts_url, ts_path, user_name, user_pass);

            // ###########################################################
            // Here we want to test the login to Tableau Server by calling
            // the tsLogin() function from the REST API library.  If the
            // username and password is not correct, or if this user is not
            // allowed to access the Tableau Server, this function will fail.
            // We use try/catch so that we can handle the failure and we set
            // the my_tok variable to "failed" so that we can handle the 
            // failure.
            try
            {
                ArrayList login_array = tc.tsLogin();
                my_tok = login_array[0].ToString();
                my_site_id = login_array[1].ToString();
                my_user_id = login_array[2].ToString();
            }
            catch(Exception e)
            {
                my_tok = "failed"; 
            }

            // ###########################################################
            // We save the my_tok variable to the return results array. At 
            // a minimum send back the token response
            results.Add(my_tok);

            // ###########################################################
            // If my_tok is not equal to "failed", we will proceed to load 
            // the rest of the information that we need to power the portal.
            if (my_tok != "failed")
            {

                // ###########################################################
                // Here we get the user information by calling the
                // tsGetUserById() function, passing in the user_id from the 
                // login above.
                ArrayList user_info = tc.tsGetUserById(my_user_id);
                my_name = user_info[1].ToString();
                my_site_role = user_info[2].ToString();
                my_last_login = user_info[3].ToString();
                my_full_name = user_info[4].ToString();

                // ###########################################################
                // Here we setup the my_workbooks_new array to hold any workbooks
                // that this user has access to.
                DataTable my_workbooks_new = new DataTable();
                my_workbooks_new.Columns.AddRange(new DataColumn[]
                {
                    new DataColumn("id", typeof(string)),
                    new DataColumn("name", typeof(string)),
                    new DataColumn("project_id", typeof(string)),
                    new DataColumn("project_name", typeof(string)),
                    new DataColumn("owner_id", typeof(string)),
                    new DataColumn("owner_name", typeof(string)),
                    new DataColumn("default_view", typeof(string))
                });

                // ###########################################################
                // Now we call the tsGetWorkbooksByUser() and pass it the 
                // user_name varialbe.  This will return a DataTable with all
                // of the workbooks that this user has access to.
                DataTable workbooks_list = tc.tsGetWorkbooksByUser(user_name);
                int workbook_cnt = workbooks_list.Rows.Count;

                // ###########################################################
                // Loop through each workbook so that we can store the information
                // of all the workbooks as a JSON array.
                foreach (DataRow row in workbooks_list.Rows)
                {
                    string project_name = row["project_name"].ToString();
                    string workbook_id = row["id"].ToString();
                    string workbook_name = row["name"].ToString();
                    string user_id = row["owner_id"].ToString();
                    string project_id = row["project_id"].ToString();

                    // ###########################################################
                    // We only want to show workbooks that have a "Portal" tag so
                    // we get the tags from the workbook and check for the 'portal'
                    // tag.
                    ArrayList tags_list = tc.tsGetWorkbookTags(workbook_id);

                    // set the test counter
                    int is_tag = 0;

                    // rip through the array and do something
                    for (int i = 0; i < tags_list.Count; i++)
                    {
                        string tag_name = tags_list[i].ToString();

                        if (tag_name.Equals("Portal"))
                        {
                            is_tag = 1;
                        }
                    }

                    // ###########################################################
                    // If the portal tag is found, then is_tag will equal 1.  If 
                    // it is, then we will continue with additional processing
                    // of this workbook.
                    if (is_tag > 0)
                    {

                        // ###########################################################
                        // Here we use the tsGetUserNameById() function to get the
                        // name of the person that owns the workbook.
                        string owner_name = tc.tsGetUserNameById(user_id);

                        // ###########################################################
                        // Here we call the tsGetViewsFromWorkbook() function to get
                        // a DataTable array of views from this workbook.  We only want
                        // the first item in the list or the first tab from the workbook.
                        DataTable wb_views = tc.tsGetViewsFromWorkbook(workbook_id);
                        string view_name = wb_views.Rows[0][1].ToString();

                        // ###########################################################
                        // get and save report thumb
                        //                        tc.tsGetWorkbookIcon(workbook_id, ugc_path + "\\" + user_id + "_" + workbook_id + ".png");

                        // ###########################################################
                        // Here we add this workbook to the my_workbooks_new DataTable
                        // array so that it can be saved and displayed later.
                        my_workbooks_new.Rows.Add(workbook_id, workbook_name, project_id, project_name, user_id, owner_name, view_name);
                    }
                }

                // ###########################################################
                // Here we sort the workbook list by project so that we can
                // display the workbooks in groups or menu options.
                DataView dv = my_workbooks_new.DefaultView;
                dv.Sort = "project_name";
                DataTable views_list_sorted = dv.ToTable();

                // ###########################################################
                // Pack the workbook list into a JSON object so that we can
                // save it into a Session variable as a single item.  We then 
                // decode it later for display.
                my_workbooks = JsonConvert.SerializeObject(views_list_sorted);

                // ###########################################################
                // Save all of the variables into a results array that can
                // be passed back from the funtion.
                results.Add(my_user_id);
                results.Add(my_site_id);
                results.Add(my_name);
                results.Add(my_site_role);
                results.Add(my_last_login);
                results.Add(my_full_name);
                results.Add(my_workbooks);
                results.Add(workbook_cnt);
                results.Add(ts_url);
                results.Add(user_name);

            }

            // ###########################################################
            // Return the results array that contains all of the options
            // that we loaded in this function.  At a minimum, the first item
            // my_tok will be returned indicating if the login was a success
            // or a failure.
            return results;

        }



    }
}