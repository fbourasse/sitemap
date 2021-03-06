Sitemap (optional module)
=========================

In which format is my sitemap available ?
-----------------------------------------

The sitemap rendering is done by templates as default we provide three types of sitemap, html, text or xml (following 
standard from sitemaps.org.

How to customize the sitemap ?
------------------------------

The sitemap will list all sub elements of the current node having the options . By default, all objects of type 
`jnt:page` will have this options automatically activated by some rules. You can add your own rules for different types, 
or you can manually activate the option on a specific content.

Here is the rule for automatically assigning the option to a newly created page.

    rule "Add sitemap mixin to page"
        salience -10
        no-loop
        when
            A new node is created
                - it has the type jnt:page
        then
            Add the type 
    end

How do I submit my sitemap to search engines like Google, Yahoo!, Microsoft ?
-----------------------------------------------------------------------------

The submission of your sitemap can be done automatically by a background job in Jahia Digital Experience Manager. This 
job is defined inside the sitemap module.

    <bean id="sitemapCronTrigger" class="org.quartz.CronTrigger">
        <property name="name" value="SitemapCronTrigger"/>
        <!-- Will start the process at 4 a.m -->
        <property name="cronExpression" value="0 0 4 * * ?" />
    </bean>

    <bean id="sitemapJobDetail" class="org.springframework.scheduling.quartz.JobDetailBean">
        <!-- This job will call searchEnginesUrl+urlEncoded(sitesUrl+/sitemap.xml)-->
        <!-- As an example here it will call http://www.google.com/webmasters/tools/ping?sitemap=http%3A%2F%2Ftata.mondomaine.com%2Fsitemap.xml -->
        <property name="jobClass" value="org.jahia.modules.sitemap.SitemapJob"/>
        <property name="jobDataAsMap">
            <map>
                <entry key="searchEngines">
                    <list>
                        <value>http://www.google.com/webmasters/tools/ping?sitemap=</value>
                    </list>
                </entry>
                <entry key="sites">
                    <list>
                        <value>http://example.domain.com</value>
                    </list>
                </entry>
            </map>
        </property>
    </bean>

This job is define in two parts first we have the trigger. The trigger is here to define at which time we want to 
execute the job. Here we use a cron expression to define the time of execution (here 4 AM every day of every year).

The second part is the job by itself, where you can configure how many search engines you want to reach by specifying 
the url where to submit the sitemap.

Then you have to list which domain you want to submit. Here we will submit the domain/sitemap.xml. To know how to bind 
your `domain/sitemap.xml` to your homepage look at the documentation about Apache HTTP Server in the war module.

For each search engine, you will have to follow their policy. For example on Google, they ask that for the first time 
you manually register you sitemap using their webmaster tools (to follow what happens and have feedback in your 
Google environment).