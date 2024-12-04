codeunit 82031 ARD_AOC202403 implements ARD_AdventOfCodeProcessor
{

    /// <summary>
    /// Calculates the result based on the input data from the ARD_AOCChallenge record.
    /// </summary>
    /// <param name="Rec">The ARD_AOCChallenge record containing the challenge data.</param>
    /// <param name="RunExample">Boolean flag indicating whether to run the example data or the actual challenge data.</param>
    /// <returns>An integer representing the calculated result.</returns>
    /// <remarks>
    /// This procedure retrieves the challenge data or example data based on the RunExample flag.
    /// It then uses a regular expression to find all matches of the pattern 'mul(d+,d+)' in the input data.
    /// For each match, it extracts the two integer values, multiplies them, and adds the result to the total.
    /// </remarks>
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

    /// <summary>
    /// Calculates the result based on the provided record and example flag.
    /// </summary>
    /// <param name="Rec">The record containing the challenge data.</param>
    /// <param name="RunExample">Boolean flag to determine if example data should be used.</param>
    /// <returns>The calculated result as an integer.</returns>
    /// <remarks>
    /// This procedure retrieves the challenge data or example data based on the RunExample flag.
    /// It then uses a regex pattern to find matches in the input data. The pattern looks for
    /// multiplication operations (mul(x,y)), and control operations (do() and don't()).
    /// The result is calculated by performing the multiplication operations only when the
    /// Calculate flag is true, which is controlled by the do() and don't() operations.
    /// </remarks>
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
