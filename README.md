# tableau-portal-aspx

A sample portal for Tableau Server written in ASP.NET

## Confirm prerequisites

Before you run the sample, you need the following prerequisites:

* Tableau Server
* Visual Studio
* IIS

You must also register .NET with IIS. For more information, see [ASP.NET IIS Registration
Tool](https://msdn.microsoft.com/en-us/library/k6h9cz8h.aspx) on the MSDN library.

## Configure the Tableau Server URL

By default, the sample attempts to connect to an instance of Tableau Server on localhost. To specify another URL, edit
the \_includes/header.ascx.cs file and edit the following line:

```java
string ts_url = "http://localhost";
```

## Tag workbooks on Tableau Server

The sample gets all the views on Tableau Server that have the `Portal` tag. Add the tag to your views before you run the
sample.

## Run the sample

1. Open the `ProPortal-Portal.csproj` project file in Visual Studio.
   Visual Studio creates a solution file. Save the file before you continue.

1. Click **Build** > **Build Solution**.
   **Note**: Visual Studio restores package dependencies with NuGet. Ensure that NuGet package restore is enabled.

1. Click **Build** > **Publish**.

1. Create a profile to publish the sample to a web server.

After you publish the sample, navigate to the web server URL and play with the sample!

## Using the REST API library for .NET

This sample uses an unofficial client library for Tableau Server. For more information, see the project homepage:

<http://dev.datapainters.com/products/tableau_rest_connector/>
