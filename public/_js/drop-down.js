function initPage()
{
	var n = document.getElementById("nav");
	if (n)
	{
		var lis = n.getElementsByTagName("li");
		for (var i = 0; i < lis.length; i++)
		{
			if (lis[i].getElementsByTagName("ul").length)
			{
				if (lis[i].parentNode.id == "nav")
				{
					var a = lis[i].getElementsByTagName("a").item(0);
					if (a)
					{
						a.onclick = function ()
						{
							var p = this.parentNode;
							if (p.className.indexOf("active") != -1)
								p.className = p.className.replace("active", "");
							else
								p.className += " active";
							return false;
						}
					}
				}
			}
		}
	}
}

if (window.addEventListener)
	window.addEventListener("load", initPage, false);
else if (window.attachEvent)
	window.attachEvent("onload", initPage);
