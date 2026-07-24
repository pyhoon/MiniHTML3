B4J=true
Group=Views
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
' MiniHtml Boilerplate class
' Version: 3.10
End Sub

Public Sub Show As String
	Dim doc As MiniHtml
	doc.Initialize("doctype")
	doc.Append(Page.build)
	Return doc.ToString
End Sub

Public Sub Page As MiniHtml
	Dim page1 As MiniHtml = MH.Html
	Dim head1 As MiniHtml = MH.ResponsiveHeader.up(page1)
	MH.Title.up(head1).text("$APP_TITLE$")
	'MH.FavoriteIcon("image/png", "$SERVER_URL$/assets/img/favicon.png").up(head1)
	head1.cdn("css", "$SERVER_URL$/assets/css/bootstrap.min.css")
	Dim body1 As MiniHtml = MH.Body
	'MH.CopyrightFooter.up(body1)
	body1.cdn("js", "$SERVER_URL$/assets/js/bootstrap.min.js")
	Return page1
End Sub