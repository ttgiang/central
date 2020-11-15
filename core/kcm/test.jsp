
<!DOCTYPE html>
<html ng-app="angularjs-starter">
  
  <head lang="en">
    <meta charset="utf-8">
    <title>Custom Plunker</title>
  
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular.js"></script>
    <script src="http://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.4.0.min.js"></script>
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.no-icons.min.css" rel="stylesheet">
  

    <script src="app.js"></script>
  </head>
  
  <body ng-controller="MainCtrl">
    <p> Tooltips on table cells (td). Hovering over "hello" cells causes layout to be messed up</p>
    <table class="table table-bordered">
      <tbody>
        <tr>
          <td tooltip="hello" tooltip-append-to-body="true">Hello</td>  
          <td tooltip="world" tooltip-append-to-body="true"> World </td>
        </tr>      
        <tr>
          <td tooltip="hello" tooltip-append-to-body="true">Hello</td>  
          <td tooltip="world" tooltip-append-to-body="true"> World </td>
        </tr>      
      </tbody>
    </table>
    
    <p> Tooltips on table cells with an internal span: Hovering works fine but only if you hover over text</p>
    <table class="table table-bordered">
      <tbody>
        <tr>
          <td><span tooltip="hello">Hello</span></td>  
          <td><span tooltip="world"> World </span></td>
        </tr>        
        <tr>
          <td><span tooltip="hello">Hello</span></td>  
          <td><span tooltip="world"> World </span></td>
        </tr>      
      </tbody>
    </table>
    
    
</body>

</html>