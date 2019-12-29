# Namespace management
$g_nsmgr = New-Object System.Xml.XmlNamespaceManager (new-object System.Xml.NameTable)
$g_nsmgr.AddNamespace("msbuild", "http://schemas.microsoft.com/developer/msbuild/2003")
$g_nsmgr.AddNamespace("nuspec", "http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd")

# Usage: $xml.SelectSingleNode("//msbuild:Item", $g_nsmgr)