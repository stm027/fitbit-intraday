intraday <- function(StartDate,EndDate,data,file.name,email,password) {
        
        require(reshape2)
        require(fitbitScraper)
        require(stringr)
        
        cookie <- login(email=email,password=password)
        
        #Creates a list of dates
        
        index<-as.character(
                seq(as.Date(StartDate),as.Date(EndDate), "days"))
        
        #Creates empty list
        
        x<-length(index)
        output.list <- vector('list', length(x))
        
        #Creates a list of dataframes for fitbitscraper outputs for each date in index
        
        for (i in seq_along(index)) {
               a<-get_intraday_data(cookie, what=data, date=index[i])
        output.list[[i]]<-a}
        
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
