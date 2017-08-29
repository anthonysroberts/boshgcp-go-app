APP_DIR=/var/vcap/sys/run/boshgcp-go-app
LOG_DIR=/var/vcap/sys/log/boshgcp-go-app
PIDFILE=${APP_DIR}/pid
RUN_USER=vcap
 
case $1 in
     
     start)
         mkdir -p $APP_DIR $LOG_DIR
         chown -R $RUN_USER:$RUN_USER $APP_DIR $LOG_DIR
                             
         echo $$ > $PIDFILE
                                     
         cd /var/vcap/packages/boshgcp-go-app
                                             
         exec /var/vcap/packages/boshgcp-go-app/bin/boshgcp-go-app \
             >>  $LOG_DIR/boshgcp-go-app.stdout.log \
             2>> $LOG_DIR/boshgcp-go-app.stderr.log
                                                     
         ;;
                                                             
     stop)
         kill -9 `cat $PIDFILE` && rm -f $PIDFILE
         ;;
                                                          
     *)
         echo "Usage: ctl {start|stop}" ;;
                                                                                                     
     esac
