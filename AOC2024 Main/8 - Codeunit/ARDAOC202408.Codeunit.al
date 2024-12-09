codeunit 82035 ARD_AOC202408 implements ARD_AdventOfCodeProcessor
{
    //This would have helped: https://github.com/Microsoft/AL/issues/1668

    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Decimal
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Lines: List of [Text];
        Matrix: list of [list of [Char]];
        TextValue: Text;
        CharArray: list of [Char];
        testChar: Char;
    begin
        if RunExample then
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TextValue in lines do begin
            clear(CharArray);
            foreach testChar in TextValue.ToLower() do
                CharArray.Add(testChar);

            Matrix.add(CharArray);
        end;

        exit(ProcessNodes(Matrix));
    end;

    local procedure ProcessNodes(var Matrix: list of [list of [Char]]): Decimal
    var
        Result: Decimal;
        MatrixRow: List of [Char];
        NodeList: List of [Text];
        Row: Integer;
        Column: integer;
        Node: char;
    begin
        Result := 0;
        Row := 0;
        foreach MatrixRow in Matrix do begin
            Column := 0;
            Row += 1;
            foreach Node in MatrixRow do begin
                Column += 1;
                if Node <> '.' then
                    Result += ProcessNode(Matrix, NodeList, Node, Row, Column);
            end;
        end;

        exit(Result);
    end;

    local procedure ProcessNode(var Matrix: list of [list of [Char]]; var NodeList: List of [Text]; NodeValue: char; NodeRow: integer; NodeColumn: integer): Integer
    var
        MatrixRow: List of [Char];
        NodeLocation: Text;
        Row: integer;
        Column: Integer;
        Node: char;
        antiNodeX: Integer;
        antiNodeY: Integer;
        Results: Integer;
    begin
        Results := 0;
        Row := 0;
        foreach MatrixRow in Matrix do begin
            Column := 0;
            Row += 1;
            foreach Node in MatrixRow do begin
                Column += 1;
                if (Node = NodeValue) and ((Column <> NodeColumn) or (Row <> NodeRow)) then begin
                    //Calculate upper antinode
                    antiNodeX := NodeColumn + (NodeColumn - Column);
                    antiNodeY := NodeRow + (NodeRow - Row);
                    if (antinodeX > 0) and (antinodeX <= Matrix.get(1).Count) and (antinodeY > 0) and (antinodeY <= Matrix.Count) then begin
                        NodeLocation := format(antiNodeX) + ',' + format(antiNodeY);
                        if not NodeList.Contains(NodeLocation) then begin
                            NodeList.Add(NodeLocation);
                            Results += 1;
                        end;
                    end;
                    
                    //Calculate lower antinode
                    antiNodeX := Column - (NodeColumn - Column);
                    antiNodeY := Row - (NodeRow - Row);
                    if (antinodeX > 0) and (antinodeX <= Matrix.get(1).Count) and (antinodeY > 0) and (antinodeY <= Matrix.Count) then begin
                        NodeLocation := format(antiNodeX) + ',' + format(antiNodeY);
                        if not NodeList.Contains(NodeLocation) then begin
                            NodeList.Add(NodeLocation);
                            Results += 1;
                        end;
                    end;
                end;
            end;
        end;

        exit(Results);
    end;

    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Decimal
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Lines: List of [Text];
        Matrix: list of [list of [text]];
        TextValue: Text;
        CharArray: list of [text];
        testChar: Char;
    begin
        if RunExample then
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TextValue in lines do begin
            clear(CharArray);
            foreach testChar in TextValue.ToLower() do
                CharArray.Add(testChar);

            Matrix.add(CharArray);
        end;
    end;

}
