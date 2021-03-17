rsconnect::setAccountInfo(name='mnielsen', 
                          token=Sys.getenv('token'), 
                          secret=Sys.getenv('secret'))

rsconnect::deployApp(appName = 'ncaa-calcutta-eaids')

rsconnect::deployApp(appName = 'ncaa-calcutta-castell')
