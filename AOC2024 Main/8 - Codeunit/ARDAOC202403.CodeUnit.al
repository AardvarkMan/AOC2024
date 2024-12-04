codeunit 82031 ARD_AOC202403 implements ARD_AdventOfCodeProcessor
{

    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        Matches: Record Matches temporary;
        AOCSupport: Codeunit ARD_AOCSupport;
        Regex: CodeUnit Regex;
        Pattern: Text;
        Inputs: Text;
        MatchText: Text;
        tmpText: Text;
        Result: Integer;
        Values: List of [Text];
        Value1: Integer;
        Value2: Integer;
    begin
        Result := 0;
        if RunExample then
            Inputs := Rec.RetrieveChallengeExample()
        else
            Inputs := Rec.RetrieveChallengeData();

        Pattern := 'mul\(\d+,\d+\)';

        Regex.Match(Inputs, Pattern, Matches);

        if Matches.FindSet() then begin
            repeat
                MatchText := Matches.ReadValue();
                MatchText := MatchText.Remove(1, 4);
                MatchText := MatchText.Replace(')', '');
                Values := MatchText.Split(',');
                System.Evaluate(Value1, Values.get(1));
                System.Evaluate(Value2, Values.get(2));
                Result := Result + (Value1 * Value2);
            until Matches.Next() = 0;
        end;

        exit(Result);
    end;

    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        Matches: Record Matches temporary;
        AOCSupport: Codeunit ARD_AOCSupport;
        Regex: CodeUnit Regex;
        Pattern: Text;
        Inputs: Text;
        MatchText: Text;
        tmpText: Text;
        Result: Integer;
        Values: List of [Text];
        Value1: Integer;
        Value2: Integer;
        Calculate: Boolean;
    begin
        Result := 0;
        if RunExample then
            Inputs := Rec.RetrieveChallengeExample()
        else
            Inputs := Rec.RetrieveChallengeData();

        Pattern := 'mul\(\d+,\d+\)|do\(\)|don''t\(\)';

        Regex.Match(Inputs, Pattern, Matches);

        Calculate := true;
        if Matches.FindSet() then begin
            repeat
                MatchText := Matches.ReadValue();
                if MatchText.ToLower() = 'do()' then
                    Calculate := true
                else if MatchText.ToLower() = 'don''t()' then
                    Calculate := false
                else begin
                    if Calculate then begin
                        MatchText := MatchText.Remove(1, 4);
                        MatchText := MatchText.Replace(')', '');
                        Values := MatchText.Split(',');
                        System.Evaluate(Value1, Values.get(1));
                        System.Evaluate(Value2, Values.get(2));
                        Result := Result + (Value1 * Value2);
                    end;
                end;

            until Matches.Next() = 0;
        end;

        exit(Result);
    end;
}
