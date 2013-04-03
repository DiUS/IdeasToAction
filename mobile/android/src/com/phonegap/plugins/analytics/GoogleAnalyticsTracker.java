  


<!DOCTYPE html>
<html>
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# githubog: http://ogp.me/ns/fb/githubog#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>phonegap-plugins/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java at master · phonegap/phonegap-plugins · GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png" />
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png" />
    <link rel="logo" type="image/svg" href="http://github-media-downloads.s3.amazonaws.com/github-logo.svg" />
    <meta name="msapplication-TileImage" content="/windows-tile.png">
    <meta name="msapplication-TileColor" content="#ffffff">

    
    
    <link rel="icon" type="image/x-icon" href="/favicon.ico" />

    <meta content="authenticity_token" name="csrf-param" />
<meta content="UURak8Y1gd+y0jYmnkl3QfQFhBVe+iXTLT8AP+CnYLU=" name="csrf-token" />

    <link href="https://a248.e.akamai.net/assets.github.com/assets/github-f70e4783e00fd4884a9e5e651a43933c9881caa8.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://a248.e.akamai.net/assets.github.com/assets/github2-d9eb9a2232d0234204789505723cea9a41e3b53a.css" media="all" rel="stylesheet" type="text/css" />
    


      <script src="https://a248.e.akamai.net/assets.github.com/assets/frameworks-d76b58e749b52bc47a4c46620bf2c320fabe5248.js" type="text/javascript"></script>
      <script src="https://a248.e.akamai.net/assets.github.com/assets/github-67b55380cff8d6766b298e6935a3c1db7d5c6d5d.js" type="text/javascript"></script>
      
      <meta http-equiv="x-pjax-version" content="1212ad79754350a805cefbcd08a3dadf">

        <link data-pjax-transient rel='permalink' href='/phonegap/phonegap-plugins/blob/710bfd54751e5526974ec122d4d7be78dc73c3a5/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java'>
    <meta property="og:title" content="phonegap-plugins"/>
    <meta property="og:type" content="githubog:gitrepository"/>
    <meta property="og:url" content="https://github.com/phonegap/phonegap-plugins"/>
    <meta property="og:image" content="https://secure.gravatar.com/avatar/467b6e8a473f45a15ac9514a30c15c3d?s=420&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"/>
    <meta property="og:site_name" content="GitHub"/>
    <meta property="og:description" content="phonegap-plugins - Plugins for use with PhoneGap. "/>
    <meta property="twitter:card" content="summary"/>
    <meta property="twitter:site" content="@GitHub">
    <meta property="twitter:title" content="phonegap/phonegap-plugins"/>

    <meta name="description" content="phonegap-plugins - Plugins for use with PhoneGap. " />

  <link href="https://github.com/phonegap/phonegap-plugins/commits/master.atom" rel="alternate" title="Recent Commits to phonegap-plugins:master" type="application/atom+xml" />

  </head>


  <body class="logged_out page-blob linux vis-public fork env-production  ">
    <div id="wrapper">

      

      
      
      

      
      <div class="header header-logged-out">
  <div class="container clearfix">

      <a class="header-logo-wordmark" href="https://github.com/">Github</a>

      <ul class="top-nav">
          <li class="explore"><a href="https://github.com/explore">Explore GitHub</a></li>
        <li class="search"><a href="https://github.com/search">Search</a></li>
        <li class="features"><a href="https://github.com/features">Features</a></li>
          <li class="blog"><a href="https://github.com/blog">Blog</a></li>
      </ul>

    <div class="header-actions">
        <a class="button primary" href="https://github.com/signup">Sign up for free</a>
      <a class="button" href="https://github.com/login?return_to=%2Fphonegap%2Fphonegap-plugins%2Fblob%2Fmaster%2FAndroid%2FAnalytics%2F2.0%2Fsrc%2Fcom%2Fphonegap%2Fplugins%2Fanalytics%2FGoogleAnalyticsTracker.java">Sign in</a>
    </div>

  </div>
</div>


      

      


            <div class="site hfeed" itemscope itemtype="http://schema.org/WebPage">
      <div class="hentry">
        
        <div class="pagehead repohead instapaper_ignore readability-menu ">
          <div class="container">
            <div class="title-actions-bar">
              


<ul class="pagehead-actions">



    <li>
      <a href="/login?return_to=%2Fphonegap%2Fphonegap-plugins"
        class="minibutton js-toggler-target star-button entice tooltipped upwards"
        title="You must be signed in to use this feature" rel="nofollow">
        <span class="mini-icon mini-icon-star"></span>Star
      </a>
      <a class="social-count js-social-count" href="/phonegap/phonegap-plugins/stargazers">
        2,916
      </a>
    </li>
    <li>
      <a href="/login?return_to=%2Fphonegap%2Fphonegap-plugins"
        class="minibutton js-toggler-target fork-button entice tooltipped upwards"
        title="You must be signed in to fork a repository" rel="nofollow">
        <span class="mini-icon mini-icon-fork"></span>Fork
      </a>
      <a href="/phonegap/phonegap-plugins/network" class="social-count">
        2,228
      </a>
    </li>
</ul>

              <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
                <span class="repo-label"><span>public</span></span>
                <span class="mega-icon mega-icon-public-repo"></span>
                <span class="author vcard">
                  <a href="/phonegap" class="url fn" itemprop="url" rel="author">
                  <span itemprop="title">phonegap</span>
                  </a></span> /
                <strong><a href="/phonegap/phonegap-plugins" class="js-current-repository">phonegap-plugins</a></strong>
                  <span class="fork-flag">
                    <span class="text">forked from <a href="/purplecabbage/phonegap-plugins">purplecabbage/phonegap-plugins</a></span>
                  </span>
              </h1>
            </div>

            
  <ul class="tabs">
    <li><a href="/phonegap/phonegap-plugins" class="selected" highlight="repo_source repo_downloads repo_commits repo_tags repo_branches">Code</a></li>
    <li><a href="/phonegap/phonegap-plugins/network" highlight="repo_network">Network</a></li>
    <li><a href="/phonegap/phonegap-plugins/pulls" highlight="repo_pulls">Pull Requests <span class='counter'>79</span></a></li>

      <li><a href="/phonegap/phonegap-plugins/issues" highlight="repo_issues">Issues <span class='counter'>344</span></a></li>

      <li><a href="/phonegap/phonegap-plugins/wiki" highlight="repo_wiki">Wiki</a></li>


    <li><a href="/phonegap/phonegap-plugins/graphs" highlight="repo_graphs repo_contributors">Graphs</a></li>


  </ul>
  
<div class="tabnav">

  <span class="tabnav-right">
    <ul class="tabnav-tabs">
          <li><a href="/phonegap/phonegap-plugins/tags" class="tabnav-tab" highlight="repo_tags">Tags <span class="counter ">4</span></a></li>
    </ul>
    
  </span>

  <div class="tabnav-widget scope">


    <div class="select-menu js-menu-container js-select-menu js-branch-menu">
      <a class="minibutton select-menu-button js-menu-target" data-hotkey="w" data-ref="master">
        <span class="mini-icon mini-icon-branch"></span>
        <i>branch:</i>
        <span class="js-select-button">master</span>
      </a>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container">

        <div class="select-menu-modal">
          <div class="select-menu-header">
            <span class="select-menu-title">Switch branches/tags</span>
            <span class="mini-icon mini-icon-remove-close js-menu-close"></span>
          </div> <!-- /.select-menu-header -->

          <div class="select-menu-filters">
            <div class="select-menu-text-filter">
              <input type="text" id="commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
            </div>
            <div class="select-menu-tabs">
              <ul>
                <li class="select-menu-tab">
                  <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
                </li>
                <li class="select-menu-tab">
                  <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
                </li>
              </ul>
            </div><!-- /.select-menu-tabs -->
          </div><!-- /.select-menu-filters -->

          <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket css-truncate" data-tab-filter="branches">

            <div data-filterable-for="commitish-filter-field" data-filterable-type="substring">

                <div class="select-menu-item js-navigation-item js-navigation-target selected">
                  <span class="select-menu-item-icon mini-icon mini-icon-confirm"></span>
                  <a href="/phonegap/phonegap-plugins/blob/master/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="master" rel="nofollow" title="master">master</a>
                </div> <!-- /.select-menu-item -->
            </div>

              <div class="select-menu-no-results">Nothing to show</div>
          </div> <!-- /.select-menu-list -->


          <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket css-truncate" data-tab-filter="tags">
            <div data-filterable-for="commitish-filter-field" data-filterable-type="substring">

                <div class="select-menu-item js-navigation-item js-navigation-target ">
                  <span class="select-menu-item-icon mini-icon mini-icon-confirm"></span>
                  <a href="/phonegap/phonegap-plugins/blob/init/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="init" rel="nofollow" title="init">init</a>
                </div> <!-- /.select-menu-item -->
                <div class="select-menu-item js-navigation-item js-navigation-target ">
                  <span class="select-menu-item-icon mini-icon mini-icon-confirm"></span>
                  <a href="/phonegap/phonegap-plugins/blob/PG141/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="PG141" rel="nofollow" title="PG141">PG141</a>
                </div> <!-- /.select-menu-item -->
                <div class="select-menu-item js-navigation-item js-navigation-target ">
                  <span class="select-menu-item-icon mini-icon mini-icon-confirm"></span>
                  <a href="/phonegap/phonegap-plugins/blob/BasicCLforIOS/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="BasicCLforIOS" rel="nofollow" title="BasicCLforIOS">BasicCLforIOS</a>
                </div> <!-- /.select-menu-item -->
                <div class="select-menu-item js-navigation-item js-navigation-target ">
                  <span class="select-menu-item-icon mini-icon mini-icon-confirm"></span>
                  <a href="/phonegap/phonegap-plugins/blob/AdPlugin-20100712/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="AdPlugin-20100712" rel="nofollow" title="AdPlugin-20100712">AdPlugin-20100712</a>
                </div> <!-- /.select-menu-item -->
            </div>

            <div class="select-menu-no-results">Nothing to show</div>

          </div> <!-- /.select-menu-list -->

        </div> <!-- /.select-menu-modal -->
      </div> <!-- /.select-menu-modal-holder -->
    </div> <!-- /.select-menu -->

  </div> <!-- /.scope -->

  <ul class="tabnav-tabs">
    <li><a href="/phonegap/phonegap-plugins" class="selected tabnav-tab" highlight="repo_source">Files</a></li>
    <li><a href="/phonegap/phonegap-plugins/commits/master" class="tabnav-tab" highlight="repo_commits">Commits</a></li>
    <li><a href="/phonegap/phonegap-plugins/branches" class="tabnav-tab" highlight="repo_branches" rel="nofollow">Branches <span class="counter ">1</span></a></li>
  </ul>

</div>

  
  
  


            
          </div>
        </div><!-- /.repohead -->

        <div id="js-repo-pjax-container" class="container context-loader-container" data-pjax-container>
          


<!-- blob contrib key: blob_contributors:v21:0abceed82520a006cd772472b95b3ebd -->
<!-- blob contrib frag key: views10/v8/blob_contributors:v21:0abceed82520a006cd772472b95b3ebd -->


<div id="slider">
    <div class="frame-meta">

      <p title="This is a placeholder element" class="js-history-link-replace hidden"></p>

        <div class="breadcrumb">
          <span class='bold'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/phonegap/phonegap-plugins" class="js-slide-to" data-branch="master" data-direction="back" itemscope="url"><span itemprop="title">phonegap-plugins</span></a></span></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/phonegap/phonegap-plugins/tree/master/Android" class="js-slide-to" data-branch="master" data-direction="back" itemscope="url"><span itemprop="title">Android</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/phonegap/phonegap-plugins/tree/master/Android/Analytics" class="js-slide-to" data-branch="master" data-direction="back" itemscope="url"><span itemprop="title">Analytics</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/phonegap/phonegap-plugins/tree/master/Android/Analytics/2.0" class="js-slide-to" data-branch="master" data-direction="back" itemscope="url"><span itemprop="title">2.0</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/phonegap/phonegap-plugins/tree/master/Android/Analytics/2.0/src" class="js-slide-to" data-branch="master" data-direction="back" itemscope="url"><span itemprop="title">src</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/phonegap/phonegap-plugins/tree/master/Android/Analytics/2.0/src/com" class="js-slide-to" data-branch="master" data-direction="back" itemscope="url"><span itemprop="title">com</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/phonegap/phonegap-plugins/tree/master/Android/Analytics/2.0/src/com/phonegap" class="js-slide-to" data-branch="master" data-direction="back" itemscope="url"><span itemprop="title">phonegap</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/phonegap/phonegap-plugins/tree/master/Android/Analytics/2.0/src/com/phonegap/plugins" class="js-slide-to" data-branch="master" data-direction="back" itemscope="url"><span itemprop="title">plugins</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/phonegap/phonegap-plugins/tree/master/Android/Analytics/2.0/src/com/phonegap/plugins/analytics" class="js-slide-to" data-branch="master" data-direction="back" itemscope="url"><span itemprop="title">analytics</span></a></span><span class="separator"> / </span><strong class="final-path">GoogleAnalyticsTracker.java</strong> <span class="js-zeroclipboard zeroclipboard-button" data-clipboard-text="Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java" data-copied-hint="copied!" title="copy to clipboard"><span class="mini-icon mini-icon-clipboard"></span></span>
        </div>

      <a href="/phonegap/phonegap-plugins/find/master" class="js-slide-to" data-hotkey="t" style="display:none">Show File Finder</a>


        
  <div class="commit file-history-tease">
    <img class="main-avatar" height="24" src="https://secure.gravatar.com/avatar/4804b35cfb9b444175d6567d0a448855?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
    <span class="author"><a href="/robdiciuccio" rel="author">robdiciuccio</a></span>
    <time class="js-relative-date" datetime="2012-11-09T09:49:18-08:00" title="2012-11-09 09:49:18">November 09, 2012</time>
    <div class="commit-title">
        <a href="/phonegap/phonegap-plugins/commit/5fb8d51ca5f4d99119df0ca1b72a6d56079b577d" class="message">Android/Analytics: exclude invalid default scope in setCustomVar</a>
    </div>

    <div class="participation">
      <p class="quickstat"><a href="#blob_contributors_box" rel="facebox"><strong>2</strong> contributors</a></p>
          <a class="avatar tooltipped downwards" title="robdiciuccio" href="/phonegap/phonegap-plugins/commits/master/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java?author=robdiciuccio"><img height="20" src="https://secure.gravatar.com/avatar/4804b35cfb9b444175d6567d0a448855?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="20" /></a>
    <a class="avatar tooltipped downwards" title="broderix" href="/phonegap/phonegap-plugins/commits/master/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java?author=broderix"><img height="20" src="https://secure.gravatar.com/avatar/c13932924bdff951a67d91e9eef24a88?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="20" /></a>


    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2>Users on GitHub who have contributed to this file</h2>
      <ul class="facebox-user-list">
        <li>
          <img height="24" src="https://secure.gravatar.com/avatar/4804b35cfb9b444175d6567d0a448855?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
          <a href="/robdiciuccio">robdiciuccio</a>
        </li>
        <li>
          <img height="24" src="https://secure.gravatar.com/avatar/c13932924bdff951a67d91e9eef24a88?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
          <a href="/broderix">broderix</a>
        </li>
      </ul>
    </div>
  </div>


    </div><!-- ./.frame-meta -->

    <div class="frames">
      <div class="frame" data-permalink-url="/phonegap/phonegap-plugins/blob/710bfd54751e5526974ec122d4d7be78dc73c3a5/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java" data-title="phonegap-plugins/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java at master · phonegap/phonegap-plugins · GitHub" data-type="blob">

        <div id="files" class="bubble">
          <div class="file">
            <div class="meta">
              <div class="info">
                <span class="icon"><b class="mini-icon mini-icon-text-file"></b></span>
                <span class="mode" title="File Mode">file</span>
                  <span>84 lines (73 sloc)</span>
                <span>2.768 kb</span>
              </div>
              <div class="actions">
                <div class="button-group">
                      <a class="minibutton js-entice" href=""
                         data-entice="You must be signed in and on a branch to make or propose changes">Edit</a>
                  <a href="/phonegap/phonegap-plugins/raw/master/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java" class="button minibutton " id="raw-url">Raw</a>
                    <a href="/phonegap/phonegap-plugins/blame/master/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java" class="button minibutton ">Blame</a>
                  <a href="/phonegap/phonegap-plugins/commits/master/Android/Analytics/2.0/src/com/phonegap/plugins/analytics/GoogleAnalyticsTracker.java" class="button minibutton " rel="nofollow">History</a>
                </div><!-- /.button-group -->
              </div><!-- /.actions -->

            </div>
                <div class="data type-java js-blob-data">
      <table cellpadding="0" cellspacing="0" class="lines">
        <tr>
          <td>
            <pre class="line_numbers"><span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>
<span id="L51" rel="#L51">51</span>
<span id="L52" rel="#L52">52</span>
<span id="L53" rel="#L53">53</span>
<span id="L54" rel="#L54">54</span>
<span id="L55" rel="#L55">55</span>
<span id="L56" rel="#L56">56</span>
<span id="L57" rel="#L57">57</span>
<span id="L58" rel="#L58">58</span>
<span id="L59" rel="#L59">59</span>
<span id="L60" rel="#L60">60</span>
<span id="L61" rel="#L61">61</span>
<span id="L62" rel="#L62">62</span>
<span id="L63" rel="#L63">63</span>
<span id="L64" rel="#L64">64</span>
<span id="L65" rel="#L65">65</span>
<span id="L66" rel="#L66">66</span>
<span id="L67" rel="#L67">67</span>
<span id="L68" rel="#L68">68</span>
<span id="L69" rel="#L69">69</span>
<span id="L70" rel="#L70">70</span>
<span id="L71" rel="#L71">71</span>
<span id="L72" rel="#L72">72</span>
<span id="L73" rel="#L73">73</span>
<span id="L74" rel="#L74">74</span>
<span id="L75" rel="#L75">75</span>
<span id="L76" rel="#L76">76</span>
<span id="L77" rel="#L77">77</span>
<span id="L78" rel="#L78">78</span>
<span id="L79" rel="#L79">79</span>
<span id="L80" rel="#L80">80</span>
<span id="L81" rel="#L81">81</span>
<span id="L82" rel="#L82">82</span>
<span id="L83" rel="#L83">83</span>
<span id="L84" rel="#L84">84</span>
</pre>
          </td>
          <td width="100%">
                  <div class="highlight"><pre><div class='line' id='LC1'><span class="cm">/*</span></div><div class='line' id='LC2'><span class="cm"> * PhoneGap is available under *either* the terms of the modified BSD license *or* the</span></div><div class='line' id='LC3'><span class="cm"> * MIT License (2008). See http://opensource.org/licenses/alphabetical for full text.</span></div><div class='line' id='LC4'><span class="cm"> *</span></div><div class='line' id='LC5'><span class="cm"> * Copyright (c) 2006-2011 Worklight, Ltd.  </span></div><div class='line' id='LC6'><span class="cm"> */</span></div><div class='line' id='LC7'><br/></div><div class='line' id='LC8'><span class="kn">package</span> <span class="n">com</span><span class="o">.</span><span class="na">phonegap</span><span class="o">.</span><span class="na">plugins</span><span class="o">.</span><span class="na">analytics</span><span class="o">;</span></div><div class='line' id='LC9'><br/></div><div class='line' id='LC10'><span class="kn">import</span> <span class="nn">org.apache.cordova.api.Plugin</span><span class="o">;</span></div><div class='line' id='LC11'><span class="kn">import</span> <span class="nn">org.apache.cordova.api.PluginResult</span><span class="o">;</span></div><div class='line' id='LC12'><span class="kn">import</span> <span class="nn">org.apache.cordova.api.PluginResult.Status</span><span class="o">;</span></div><div class='line' id='LC13'><span class="kn">import</span> <span class="nn">org.json.JSONArray</span><span class="o">;</span></div><div class='line' id='LC14'><span class="kn">import</span> <span class="nn">org.json.JSONException</span><span class="o">;</span></div><div class='line' id='LC15'><br/></div><div class='line' id='LC16'><span class="kn">import</span> <span class="nn">android.util.Log</span><span class="o">;</span></div><div class='line' id='LC17'><br/></div><div class='line' id='LC18'><span class="kd">public</span> <span class="kd">class</span> <span class="nc">GoogleAnalyticsTracker</span> <span class="kd">extends</span> <span class="n">Plugin</span> <span class="o">{</span></div><div class='line' id='LC19'>	<span class="kd">public</span> <span class="kd">static</span> <span class="kd">final</span> <span class="n">String</span> <span class="n">START</span> <span class="o">=</span> <span class="s">&quot;start&quot;</span><span class="o">;</span></div><div class='line' id='LC20'>	<span class="kd">public</span> <span class="kd">static</span> <span class="kd">final</span> <span class="n">String</span> <span class="n">TRACK_PAGE_VIEW</span> <span class="o">=</span> <span class="s">&quot;trackPageView&quot;</span><span class="o">;</span></div><div class='line' id='LC21'>	<span class="kd">public</span> <span class="kd">static</span> <span class="kd">final</span> <span class="n">String</span> <span class="n">TRACK_EVENT</span> <span class="o">=</span> <span class="s">&quot;trackEvent&quot;</span><span class="o">;</span></div><div class='line' id='LC22'>	<span class="kd">public</span> <span class="kd">static</span> <span class="kd">final</span> <span class="n">String</span> <span class="n">SET_CUSTOM_VARIABLE</span> <span class="o">=</span> <span class="s">&quot;setCustomVariable&quot;</span><span class="o">;</span></div><div class='line' id='LC23'>&nbsp;&nbsp;&nbsp;&nbsp;</div><div class='line' id='LC24'>	<span class="kd">public</span> <span class="kd">static</span> <span class="kd">final</span> <span class="kt">int</span> <span class="n">DISPATCH_INTERVAL</span> <span class="o">=</span> <span class="mi">20</span><span class="o">;</span></div><div class='line' id='LC25'>	<span class="kd">private</span> <span class="n">com</span><span class="o">.</span><span class="na">google</span><span class="o">.</span><span class="na">android</span><span class="o">.</span><span class="na">apps</span><span class="o">.</span><span class="na">analytics</span><span class="o">.</span><span class="na">GoogleAnalyticsTracker</span> <span class="n">tracker</span><span class="o">;</span></div><div class='line' id='LC26'><br/></div><div class='line' id='LC27'>	<span class="kd">public</span> <span class="nf">GoogleAnalyticsTracker</span><span class="o">()</span> <span class="o">{</span></div><div class='line' id='LC28'>		<span class="n">tracker</span> <span class="o">=</span> <span class="n">com</span><span class="o">.</span><span class="na">google</span><span class="o">.</span><span class="na">android</span><span class="o">.</span><span class="na">apps</span><span class="o">.</span><span class="na">analytics</span><span class="o">.</span><span class="na">GoogleAnalyticsTracker</span><span class="o">.</span><span class="na">getInstance</span><span class="o">();</span></div><div class='line' id='LC29'>	<span class="o">}</span></div><div class='line' id='LC30'><br/></div><div class='line' id='LC31'>	<span class="nd">@Override</span></div><div class='line' id='LC32'>	<span class="kd">public</span> <span class="n">PluginResult</span> <span class="nf">execute</span><span class="o">(</span><span class="n">String</span> <span class="n">action</span><span class="o">,</span> <span class="n">JSONArray</span> <span class="n">data</span><span class="o">,</span> <span class="n">String</span> <span class="n">callbackId</span><span class="o">)</span> <span class="o">{</span></div><div class='line' id='LC33'>		<span class="n">PluginResult</span> <span class="n">result</span> <span class="o">=</span> <span class="kc">null</span><span class="o">;</span></div><div class='line' id='LC34'>		<span class="k">if</span> <span class="o">(</span><span class="n">START</span><span class="o">.</span><span class="na">equals</span><span class="o">(</span><span class="n">action</span><span class="o">))</span> <span class="o">{</span></div><div class='line' id='LC35'>			<span class="k">try</span> <span class="o">{</span></div><div class='line' id='LC36'>				<span class="n">start</span><span class="o">(</span><span class="n">data</span><span class="o">.</span><span class="na">getString</span><span class="o">(</span><span class="mi">0</span><span class="o">));</span></div><div class='line' id='LC37'>				<span class="n">result</span> <span class="o">=</span> <span class="k">new</span> <span class="n">PluginResult</span><span class="o">(</span><span class="n">Status</span><span class="o">.</span><span class="na">OK</span><span class="o">);</span></div><div class='line' id='LC38'>			<span class="o">}</span> <span class="k">catch</span> <span class="o">(</span><span class="n">JSONException</span> <span class="n">e</span><span class="o">)</span> <span class="o">{</span></div><div class='line' id='LC39'>				<span class="n">result</span> <span class="o">=</span> <span class="k">new</span> <span class="n">PluginResult</span><span class="o">(</span><span class="n">Status</span><span class="o">.</span><span class="na">JSON_EXCEPTION</span><span class="o">);</span></div><div class='line' id='LC40'>			<span class="o">}</span></div><div class='line' id='LC41'>		<span class="o">}</span> <span class="k">else</span> <span class="k">if</span> <span class="o">(</span><span class="n">TRACK_PAGE_VIEW</span><span class="o">.</span><span class="na">equals</span><span class="o">(</span><span class="n">action</span><span class="o">))</span> <span class="o">{</span></div><div class='line' id='LC42'>			<span class="k">try</span> <span class="o">{</span></div><div class='line' id='LC43'>				<span class="n">trackPageView</span><span class="o">(</span><span class="n">data</span><span class="o">.</span><span class="na">getString</span><span class="o">(</span><span class="mi">0</span><span class="o">));</span></div><div class='line' id='LC44'>				<span class="n">result</span> <span class="o">=</span> <span class="k">new</span> <span class="n">PluginResult</span><span class="o">(</span><span class="n">Status</span><span class="o">.</span><span class="na">OK</span><span class="o">);</span></div><div class='line' id='LC45'>			<span class="o">}</span> <span class="k">catch</span> <span class="o">(</span><span class="n">JSONException</span> <span class="n">e</span><span class="o">)</span> <span class="o">{</span></div><div class='line' id='LC46'>				<span class="n">result</span> <span class="o">=</span> <span class="k">new</span> <span class="n">PluginResult</span><span class="o">(</span><span class="n">Status</span><span class="o">.</span><span class="na">JSON_EXCEPTION</span><span class="o">);</span></div><div class='line' id='LC47'>			<span class="o">}</span></div><div class='line' id='LC48'>		<span class="o">}</span> <span class="k">else</span> <span class="k">if</span> <span class="o">(</span><span class="n">TRACK_EVENT</span><span class="o">.</span><span class="na">equals</span><span class="o">(</span><span class="n">action</span><span class="o">))</span> <span class="o">{</span></div><div class='line' id='LC49'>			<span class="k">try</span> <span class="o">{</span></div><div class='line' id='LC50'>				<span class="n">trackEvent</span><span class="o">(</span><span class="n">data</span><span class="o">.</span><span class="na">getString</span><span class="o">(</span><span class="mi">0</span><span class="o">),</span> <span class="n">data</span><span class="o">.</span><span class="na">getString</span><span class="o">(</span><span class="mi">1</span><span class="o">),</span> <span class="n">data</span><span class="o">.</span><span class="na">getString</span><span class="o">(</span><span class="mi">2</span><span class="o">),</span> <span class="n">data</span><span class="o">.</span><span class="na">getInt</span><span class="o">(</span><span class="mi">3</span><span class="o">));</span></div><div class='line' id='LC51'>				<span class="n">result</span> <span class="o">=</span> <span class="k">new</span> <span class="n">PluginResult</span><span class="o">(</span><span class="n">Status</span><span class="o">.</span><span class="na">OK</span><span class="o">);</span></div><div class='line' id='LC52'>			<span class="o">}</span> <span class="k">catch</span> <span class="o">(</span><span class="n">JSONException</span> <span class="n">e</span><span class="o">)</span> <span class="o">{</span></div><div class='line' id='LC53'>				<span class="n">result</span> <span class="o">=</span> <span class="k">new</span> <span class="n">PluginResult</span><span class="o">(</span><span class="n">Status</span><span class="o">.</span><span class="na">JSON_EXCEPTION</span><span class="o">);</span></div><div class='line' id='LC54'>			<span class="o">}</span></div><div class='line' id='LC55'>		<span class="o">}</span> <span class="k">else</span> <span class="k">if</span> <span class="o">(</span><span class="n">SET_CUSTOM_VARIABLE</span><span class="o">.</span><span class="na">equals</span><span class="o">(</span><span class="n">action</span><span class="o">)){</span></div><div class='line' id='LC56'>			<span class="k">try</span> <span class="o">{</span></div><div class='line' id='LC57'>				<span class="n">setCustomVar</span><span class="o">(</span><span class="n">data</span><span class="o">.</span><span class="na">getInt</span><span class="o">(</span><span class="mi">0</span><span class="o">),</span> <span class="n">data</span><span class="o">.</span><span class="na">getString</span><span class="o">(</span><span class="mi">1</span><span class="o">),</span> <span class="n">data</span><span class="o">.</span><span class="na">getString</span><span class="o">(</span><span class="mi">2</span><span class="o">),</span> <span class="n">data</span><span class="o">.</span><span class="na">getInt</span><span class="o">(</span><span class="mi">3</span><span class="o">));</span></div><div class='line' id='LC58'>				<span class="n">result</span> <span class="o">=</span> <span class="k">new</span> <span class="n">PluginResult</span><span class="o">(</span><span class="n">Status</span><span class="o">.</span><span class="na">OK</span><span class="o">);</span></div><div class='line' id='LC59'>			<span class="o">}</span> <span class="k">catch</span> <span class="o">(</span><span class="n">JSONException</span> <span class="n">e</span><span class="o">)</span> <span class="o">{</span></div><div class='line' id='LC60'>				<span class="n">result</span> <span class="o">=</span> <span class="k">new</span> <span class="n">PluginResult</span><span class="o">(</span><span class="n">Status</span><span class="o">.</span><span class="na">JSON_EXCEPTION</span><span class="o">);</span></div><div class='line' id='LC61'>			<span class="o">}</span></div><div class='line' id='LC62'>		<span class="o">}</span> <span class="k">else</span> <span class="o">{</span></div><div class='line' id='LC63'>			<span class="n">result</span> <span class="o">=</span> <span class="k">new</span> <span class="n">PluginResult</span><span class="o">(</span><span class="n">Status</span><span class="o">.</span><span class="na">INVALID_ACTION</span><span class="o">);</span></div><div class='line' id='LC64'>		<span class="o">}</span></div><div class='line' id='LC65'>		<span class="k">return</span> <span class="n">result</span><span class="o">;</span></div><div class='line' id='LC66'>	<span class="o">}</span></div><div class='line' id='LC67'><br/></div><div class='line' id='LC68'>	<span class="kd">private</span> <span class="kt">void</span> <span class="nf">start</span><span class="o">(</span><span class="n">String</span> <span class="n">accountId</span><span class="o">)</span> <span class="o">{</span></div><div class='line' id='LC69'>		<span class="n">tracker</span><span class="o">.</span><span class="na">startNewSession</span><span class="o">(</span><span class="n">accountId</span><span class="o">,</span> <span class="n">DISPATCH_INTERVAL</span><span class="o">,</span> <span class="k">this</span><span class="o">.</span><span class="na">cordova</span><span class="o">.</span><span class="na">getActivity</span><span class="o">());</span></div><div class='line' id='LC70'>	<span class="o">}</span></div><div class='line' id='LC71'><br/></div><div class='line' id='LC72'>	<span class="kd">private</span> <span class="kt">void</span> <span class="nf">trackPageView</span><span class="o">(</span><span class="n">String</span> <span class="n">key</span><span class="o">)</span> <span class="o">{</span></div><div class='line' id='LC73'>		<span class="n">tracker</span><span class="o">.</span><span class="na">trackPageView</span><span class="o">(</span><span class="n">key</span><span class="o">);</span></div><div class='line' id='LC74'>	<span class="o">}</span></div><div class='line' id='LC75'><br/></div><div class='line' id='LC76'>	<span class="kd">private</span> <span class="kt">void</span> <span class="nf">trackEvent</span><span class="o">(</span><span class="n">String</span> <span class="n">category</span><span class="o">,</span> <span class="n">String</span> <span class="n">action</span><span class="o">,</span> <span class="n">String</span> <span class="n">label</span><span class="o">,</span> <span class="kt">int</span> <span class="n">value</span><span class="o">){</span></div><div class='line' id='LC77'>		<span class="n">tracker</span><span class="o">.</span><span class="na">trackEvent</span><span class="o">(</span><span class="n">category</span><span class="o">,</span> <span class="n">action</span><span class="o">,</span> <span class="n">label</span><span class="o">,</span> <span class="n">value</span><span class="o">);</span></div><div class='line' id='LC78'>	<span class="o">}</span></div><div class='line' id='LC79'><br/></div><div class='line' id='LC80'>	<span class="kd">private</span> <span class="kt">void</span> <span class="nf">setCustomVar</span><span class="o">(</span><span class="kt">int</span> <span class="n">index</span><span class="o">,</span> <span class="n">String</span> <span class="n">label</span><span class="o">,</span> <span class="n">String</span> <span class="n">value</span><span class="o">,</span> <span class="kt">int</span> <span class="n">scope</span><span class="o">)</span> <span class="o">{</span></div><div class='line' id='LC81'>		<span class="k">if</span><span class="o">(</span><span class="n">scope</span> <span class="o">&gt;</span> <span class="mi">0</span><span class="o">)</span> <span class="n">tracker</span><span class="o">.</span><span class="na">setCustomVar</span><span class="o">(</span><span class="n">index</span><span class="o">,</span> <span class="n">label</span><span class="o">,</span> <span class="n">value</span><span class="o">,</span> <span class="n">scope</span><span class="o">);</span></div><div class='line' id='LC82'>		<span class="k">else</span> <span class="n">tracker</span><span class="o">.</span><span class="na">setCustomVar</span><span class="o">(</span><span class="n">index</span><span class="o">,</span> <span class="n">label</span><span class="o">,</span> <span class="n">value</span><span class="o">);</span></div><div class='line' id='LC83'>	<span class="o">}</span></div><div class='line' id='LC84'><span class="o">}</span></div></pre></div>
          </td>
        </tr>
      </table>
  </div>

          </div>
        </div>

        <a href="#jump-to-line" rel="facebox" data-hotkey="l" class="js-jump-to-line" style="display:none">Jump to Line</a>
        <div id="jump-to-line" style="display:none">
          <h2>Jump to Line</h2>
          <form accept-charset="UTF-8" class="js-jump-to-line-form">
            <input class="textfield js-jump-to-line-field" type="text">
            <div class="full-button">
              <button type="submit" class="button">Go</button>
            </div>
          </form>
        </div>

      </div>
    </div>
</div>

<div id="js-frame-loading-template" class="frame frame-loading large-loading-area" style="display:none;">
  <img class="js-frame-loading-spinner" src="https://a248.e.akamai.net/assets.github.com/images/spinners/octocat-spinner-128.gif?1347543529" height="64" width="64">
</div>


        </div>
      </div>
      <div class="context-overlay"></div>
    </div>

      <div id="footer-push"></div><!-- hack for sticky footer -->
    </div><!-- end of wrapper - hack for sticky footer -->

      <!-- footer -->
      <div id="footer">
  <div class="container clearfix">

      <dl class="footer_nav">
        <dt>GitHub</dt>
        <dd><a href="https://github.com/about">About us</a></dd>
        <dd><a href="https://github.com/blog">Blog</a></dd>
        <dd><a href="https://github.com/contact">Contact &amp; support</a></dd>
        <dd><a href="http://enterprise.github.com/">GitHub Enterprise</a></dd>
        <dd><a href="http://status.github.com/">Site status</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>Applications</dt>
        <dd><a href="http://mac.github.com/">GitHub for Mac</a></dd>
        <dd><a href="http://windows.github.com/">GitHub for Windows</a></dd>
        <dd><a href="http://eclipse.github.com/">GitHub for Eclipse</a></dd>
        <dd><a href="http://mobile.github.com/">GitHub mobile apps</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>Services</dt>
        <dd><a href="http://get.gaug.es/">Gauges: Web analytics</a></dd>
        <dd><a href="http://speakerdeck.com">Speaker Deck: Presentations</a></dd>
        <dd><a href="https://gist.github.com">Gist: Code snippets</a></dd>
        <dd><a href="http://jobs.github.com/">Job board</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>Documentation</dt>
        <dd><a href="http://help.github.com/">GitHub Help</a></dd>
        <dd><a href="http://developer.github.com/">Developer API</a></dd>
        <dd><a href="http://github.github.com/github-flavored-markdown/">GitHub Flavored Markdown</a></dd>
        <dd><a href="http://pages.github.com/">GitHub Pages</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>More</dt>
        <dd><a href="http://training.github.com/">Training</a></dd>
        <dd><a href="https://github.com/edu">Students &amp; teachers</a></dd>
        <dd><a href="http://shop.github.com">The Shop</a></dd>
        <dd><a href="/plans">Plans &amp; pricing</a></dd>
        <dd><a href="http://octodex.github.com/">The Octodex</a></dd>
      </dl>

      <hr class="footer-divider">


    <p class="right">&copy; 2013 <span title="0.04896s from fe13.rs.github.com">GitHub</span>, Inc. All rights reserved.</p>
    <a class="left" href="https://github.com/">
      <span class="mega-icon mega-icon-invertocat"></span>
    </a>
    <ul id="legal">
        <li><a href="https://github.com/site/terms">Terms of Service</a></li>
        <li><a href="https://github.com/site/privacy">Privacy</a></li>
        <li><a href="https://github.com/security">Security</a></li>
    </ul>

  </div><!-- /.container -->

</div><!-- /.#footer -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-fullscreen-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="js-fullscreen-contents" placeholder="" data-suggester="fullscreen_suggester"></textarea>
          <div class="suggester-container">
              <div class="suggester fullscreen-suggester js-navigation-container" id="fullscreen_suggester"
                 data-url="/phonegap/phonegap-plugins/suggestions/commit">
              </div>
          </div>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped leftwards" title="Exit Zen Mode">
      <span class="mega-icon mega-icon-normalscreen"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped leftwards"
      title="Switch themes">
      <span class="mini-icon mini-icon-brightness"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="mini-icon mini-icon-exclamation"></span>
      Something went wrong with that request. Please try again.
      <a href="#" class="mini-icon mini-icon-remove-close ajax-error-dismiss"></a>
    </div>

    
    
    <span id='server_response_time' data-time='0.04938' data-host='fe13'></span>
    
  </body>
</html>

