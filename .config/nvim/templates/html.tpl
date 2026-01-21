<!doctype html>
<html>
  <head>
    <meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${1:title}</title>
    <link rel="stylesheet" type="text/css" href="components/report.css" />
    <link rel="stylesheet" type="text/css" href="components/Temml-0.13.01/dist/Temml-Latin-Modern.css" />
    <link rel="stylesheet" type="text/css" href="components/highlight/github.min.css" />
    <link rel="stylesheet" type="text/css" href="components/jsxgraph/jsxgraph.css" />
    <script src="components/jsxgraph/jsxgraphcore.js" onload="JXG.Options.text.useKatex = true"></script>
  </head>
  <body>
  <header>
      <nav class="narrownav">Mobile Nav</nav>
      <h1 id="title">${1:title}</h1>
      <hr />
  </header>
  <div class="main">
      <aside>
        <nav class="contents">
          <details open>
            <summary>
              <h3>
                <b>Content</b>
              </h3>
            </summary>
            <ul id="content"></ul>
          </details>
          <details open>
            <summary>
              <h3><b>Appendix</b></h3>
            </summary>
          </details>
          <a href="#title"><button title="go top" type="button" class="back2top">TOP</button></a>
        </nav>
      </aside>
      <article>
        <section>
		${2:content}
        </section>
	  </article>
  </div>
    <footer>
      <hr />
      email: @chaos.com
    </footer>
  </body>
  <script src="components/Temml-0.13.01/dist/temml.min.js"></script>
  <script src="components/highlight/highlight.min.js" onload="hljs.highlightAll()"></script>
  <script src="components/manualscript.js" defer></script>
</html>
