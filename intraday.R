intraday2 <- function(StartDate, EndDate, data, file.name, email, password) {
        
        require(reshape2)
        require(fitbitScraper)
        require(stringr)
        
        cookie <- login(email=email,password=password)
        
        #Creates a list of dates
        
        index<-as.character(
                seq(as.Date(StartDate),as.Date(EndDate), "days"))
        
        #Creates a list of dataframes for fitbitscraper outputs for each date in index
        
        output.list<-lapply(
                seq_along(index), 
                function(x) {
                        get_intraday_data(
                                cookie, what=data, date=index[x])})
        
        
        #Combines list into one large dataframe
        output.df<-do.call("rbind", output.list)
        
        #Splits the date column into seperate time and date columns
        
        output.df$time<-as.character(output.df$time)
        split<-str_split_fixed(output.df$time, " ", n=2)
        output.df$date<-split[,1]
        output.df$time<-split[,2]
        
        #Produces a dataframe with a column for each day and a time interval for each row
        
        melt.table<-melt(output.df)
        final.df<-dcast(melt.table, time ~ date)
        
        write.csv(final.df, file = file.name)
        print("Success!")        
}
