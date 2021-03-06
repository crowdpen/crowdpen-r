# crowdpen-r

[R](http://www.r-project.org/) library for importing [crowdpen.com](https://crowdpen.com) datasets

## Example

    library(crowdpen)
    library(aplpack)

    result <- crowdpen::fetch_results('78dn365sb3bz99', sortDir='desc')
    bagplot(crowdpen::ro(result$investors), crowdpen::ro(result$raised), xlab="Investors", ylab="Amount raised", main="Top 1000 projects cross-platform (outliers removed)")

![alt text](https://github.com/crowdpen/crowdpen-r/raw/master/pub/img/top-1k.png "Top 1k projects")


    qplot(ro(result_desc$investors), ro(result_desc$raised), xlab="Investors", ylab="Amount raised", main="Top 1000 projects cross-platform - raised 200%+ (outliers removed)", data=result_desc, color=currency)

![alt text](https://github.com/crowdpen/crowdpen-r/raw/master/pub/img/200pct-plus-top-1k.png "Top 1k projects")

    qplot(ro(result_asc$investors), ro(result_asc$raised), xlab="Investors", ylab="Amount raised", main="Top 1000 projects cross-platform - raised 200%+ (outliers removed)", data=result_asc, color=currency)

![alt text](https://github.com/crowdpen/crowdpen-r/raw/master/pub/img/200pct-plus-bottom-1k.png "Bottom 1k projects")


