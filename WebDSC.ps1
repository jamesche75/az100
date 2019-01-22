# ContosoWeb.ps1
configuration Main
{
    # Import the module that defines custom resources
    Import-DscResource -Module xPSDesiredStateConfiguration 
    Node "localhost"
    {
       # Install the IIS role
       WindowsFeature IIS
       	{
           Ensure          = "Present"
           Name            = "Web-Server"
       	}
       	# Install the ASP .NET 4.5 role
       WindowsFeature AspNet45
       {
           Ensure          = "Present"
           Name            = "Web-Asp-Net45"
       }
       # Download the website content
       xRemoteFile WebContent
       {
           Uri             = "https://cs7993fe12db3abx4d25xab6.blob.core.windows.net/public/website.zip"
           DestinationPath = "C:\inetpub\wwwroot"
           DependsOn       = "[WindowsFeature]IIS"
       }
       Archive ArchiveExample 
       {
            Ensure          = "Present"  
            Path            = "C:\inetpub\wwwroot\website.zip"
            Destination     = "C:\inetpub\wwwroot"
            DependsOn       = "[xRemoteFile]WebContent"
       } 
     }
}
