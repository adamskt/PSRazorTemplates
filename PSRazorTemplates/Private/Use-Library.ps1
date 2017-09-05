function Use-Library {
    Try
    {
        [void][RazorLight.UseEntryAssemblyMetadataResolver]
    }
    Catch
    {
        if( -not ($Library = Add-Type -path $RazorLightAssemblyPath -PassThru -ErrorAction stop) )
        {
            Throw "This module requires the ADO.NET driver for SQLite:`n`thttp://system.data.sqlite.org/index.html/doc/trunk/www/downloads.wiki"
        }
    }
}