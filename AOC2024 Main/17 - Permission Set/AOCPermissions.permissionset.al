permissionset 82024 AOCPermissions
{
    Assignable = true;
    Permissions = tabledata ARD_AOCChallenge=RIMD,
        table ARD_AOCChallenge=X,
        tabledata ARD_DoubleIntegerList=RIMD,
        table ARD_DoubleIntegerList=X,
        codeunit ARD_AOC202401=X,
        codeunit ARD_AOC202402=X,
        codeunit ARD_AOC202403=X,
        codeunit ARD_AOCProcessorFactory=X,
        codeunit ARD_AOCSupport=X,
        codeunit ARD_ResultsCalculator=X,
        page ARD_AOCChallengeCard=X,
        page ARD_AOCChallengeList=X;
}