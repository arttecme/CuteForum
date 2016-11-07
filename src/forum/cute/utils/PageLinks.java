package forum.cute.utils;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;

public class PageLinks
{
	private JspWriter out;
	
	/** 页面数字名称 - 实际序号 (比如 页面为 第一页， 实际序号为0， 则此值为1) */
	public int indexFrom = 1;
	/** 当前页面序号 */
	public int pageInd = 0;
	/** 最小页面序号 */
	public int minPageInd = 0;
	/** 最大页面序号 */
	public int maxPageInd = 12;
	/** 当前页面链接旁边最佳链接数 if 2 then 呈现出 << 2 3 [4] 5 6 >> */
	public int LINK_SIDE_SIZE = 2;
	/** 链接主体除去page参数的部分 */
	public String linkBody = "http://localhost/demp/pl.jsp?tid=10086&";
	/** page参数名 */
	public String pageParamName = "page";
	/** 第几页的名称模式 */
	public String pageNamePattern = "第{page}页";
	/** 上一页名称 */
	public String prevName = "<<";
	/** 下一页名称 */
	public String nextName = ">>";
	/** <ul>的class */
	public String ul_class = "pagination";
	/** <li>当前页时候的class */
	public String li_active_class = "active";
	
	public PageLinks(JspWriter out)
	{
		this.out = out;
	}
	
	private String toPageName(int index)
	{
		int viewInd = index+indexFrom;
		return pageNamePattern.replace("{page}", Integer.toString(viewInd));
	}
	
	private void write(String content)
	{
		try
		{
			out.println(content);
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}
	
	private void writePrevIndex()
	{
		int p = pageInd - 1;
		if(p < minPageInd) { return; }
		write( "<li><a href=\""+linkBody+pageParamName+"="+p+"\">"+prevName+"</a></li>" );
	}
	
	private void writeNextPage()
	{
		int p = pageInd + 1;
		if(p > maxPageInd) { return; }
		write( "<li><a href=\""+linkBody+pageParamName+"="+p+"\">"+nextName+"</a></li>" );
	}
	
	public void output()
	{
		int delt = 0;
		int offset = 0;
		
		write("<ul class=\""+ul_class+"\">");

		writePrevIndex();
		
		if(pageInd+LINK_SIDE_SIZE > maxPageInd)
		{
			offset = LINK_SIDE_SIZE + pageInd+LINK_SIDE_SIZE - maxPageInd;
		}
		else
		{
			offset = LINK_SIDE_SIZE;
		}
		delt = -offset;
		for(int i = 0; i < offset; i++)
		{
			int pInd = pageInd + delt;
			if(pInd >= minPageInd)
			{
				write( "<li><a href=\""+linkBody+pageParamName+"="+pInd+"\">"+toPageName(pInd)+"</a></li>" );
			}
			delt++;
		}
		
		write( "<li class=\""+li_active_class+"\"><a>"+toPageName(pageInd)+"</a></li>" );
		//write( "<li class=\""+li_active_class+"\"><a href=\""+linkBody+pageParamName+"="+pageInd+"\">"+toPageName(pageInd)+"</a></li>" );
		
		if(pageInd-LINK_SIDE_SIZE < minPageInd)
		{
			offset = LINK_SIDE_SIZE + LINK_SIDE_SIZE - pageInd + minPageInd;
		}
		else
		{
			offset = LINK_SIDE_SIZE;
		}
		delt = 1;
		for(int i = 0; i < offset; i++)
		{
			int pInd = pageInd + delt;
			if(pInd <= maxPageInd)
			{
				write( "<li><a href=\""+linkBody+pageParamName+"="+pInd+"\">"+toPageName(pInd)+"</a></li>" );
			}
			delt++;
		}
		
		writeNextPage();
		
		write("</ul>");
	}
	
	
}
