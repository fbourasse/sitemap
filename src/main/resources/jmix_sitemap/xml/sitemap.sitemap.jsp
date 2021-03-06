<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/xml;UTF-8" language="java" %>
<c:set target="${renderContext}" property="contentType" value="text/xml;charset=UTF-8"/>
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"
         xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
<jcr:jqom var="sitemaps">
    <query:selector nodeTypeName="jmix:sitemap" selectorName="stmp"/>
    <query:descendantNode path="${currentNode.path}" selectorName="stmp"/>
</jcr:jqom>
<c:choose>
    <c:when test="${((pageContext.request.scheme == 'http') && (pageContext.request.serverPort == 80)) || (pageContext.request.scheme == 'https') && (pageContext.request.serverPort == 443)}">
        <c:set var="serverUrl" value="${pageContext.request.scheme}://${pageContext.request.serverName}"/>
    </c:when>
    <c:otherwise>
        <c:set var="serverUrl" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
    </c:otherwise>
</c:choose>    

    <jcr:nodeProperty node="${currentNode}" name="jcr:lastModified" var="lastModif"/>
    <url>
        <loc>${serverUrl}<c:url value="${url.base}${currentNode.path}.html"/></loc>
        <lastmod><fmt:formatDate value="${lastModif.date.time}" pattern="yyyy-MM-dd"/></lastmod>
        <changefreq>${currentNode.properties.changefreq.string}</changefreq>
        <priority>${currentNode.properties.priority.string}</priority>
    </url>

    <c:forEach items="${sitemaps.nodes}" varStatus="status" var="sitemapEL">
        <jcr:nodeProperty node="${sitemapEL}" name="jcr:lastModified" var="lastModif"/>
        <url>
            <loc>${serverUrl}<c:url value="${url.base}${sitemapEL.path}.html"/></loc>
            <lastmod><fmt:formatDate value="${lastModif.date.time}" pattern="yyyy-MM-dd"/></lastmod>
            <changefreq>${sitemapEL.properties.changefreq.string}</changefreq>
            <priority>${sitemapEL.properties.priority.string}</priority>
        </url>
    </c:forEach>
</urlset>
