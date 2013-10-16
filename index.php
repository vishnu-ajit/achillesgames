       <head>                                                                                                                                                                    
         <title>Example</title>                                                                                                                                                  
       </head>                                                                                                                                                                   
       <body>                                                                                                                                                                    
         <?php
    require 'facebook.php';

    $app_id = '252235198257891';
    $app_secret = 'bde69cb1d4b7857664728b52beca4d78';
    $app_namespace = 'achillesgames';
    $app_url = 'https://apps.facebook.com/' . $app_namespace . '/';
    $scope = 'email,publish_actions';

    // Init the Facebook SDK
    $facebook = new Facebook(array(
         'appId'  => $app_id,
         'secret' => $app_secret,
));

// Get the current user
$user = $facebook->getUser();

// If the user has not installed the app, redirect them to the Login Dialog
if (!$user) {
        $loginUrl = $facebook->getLoginUrl(array(
        'scope' => $scope,
        'redirect_uri' => $app_url,
        ));

        print('<script> top.location.href=\'' . $loginUrl . '\'</script>');
}
?>
<script>
    var appId = '<?php echo $facebook->getAppID() ?>';
    // Initialize the JS SDK
    FB.init({
        appId: appId,
        cookie: true,
    });

    FB.getLoginStatus(function(response) {
        uid = response.authResponse.userID ? response.authResponse.userID : null;
    });
</script>

<embed src = "GoneIn30Seconds.swf" width=760 height = 600>
       </body>