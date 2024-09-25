codeunit 82025 ARD_ResultsCalculator
{
    Procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var 
        AOCFactory: Codeunit ARD_AOCProcessorFactory;
        Results: Integer;
    begin
        Results := 0;
        Results := AOCFactory.GetProcessor(Rec.ARD_Day).CalculateResult1(Rec, RunExample);
        exit(Results);
    end;

    Procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        AOCFactory: Codeunit ARD_AOCProcessorFactory;
        Results: Integer;

    begin
        Results := 0;
        Results := AOCFactory.GetProcessor(Rec.ARD_Day).CalculateResult2(Rec, RunExample);
        exit(Results);
    end;
}
