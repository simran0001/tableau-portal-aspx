# tableau-portal-aspx

A sample portal for Tableau Server written in ASP.NET

## Confirm prerequisites

Before you run the sample, you need the following prerequisites:

* Tableau Server
* Visual Studio
* IIS

You must also register .NET with IIS. For more information, see [ASP.NET IIS Registration
Tool](https://msdn.microsoft.com/en-us/library/k6h9cz8h.aspx) on the MSDN library.

## Configure the sample

* Tableau Server URL _includes/header.ascx
* Tableau Server tags

## Run the sample

1. Open the `ProPortal-Portal.csproj` project file in Visual Studio.
   Visual Studio creates a solution file. Save the file before you continue.

1. Click **Build** > **Build Solution**.
   **Note**: Visual Studio restores package dependencies with NuGet. Ensure that NuGet package restore is enabled.

1. Click **Build** > **Publish**.

1. Create a profile to publish the sample to a web server.

After you publish the sample, navigate to the web server URL and play with the sample!

