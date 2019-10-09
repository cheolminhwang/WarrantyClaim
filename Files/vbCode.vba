Public Function GetTableData() As Collection
    
End Function

Sub Test()
    Dim A As String
    Dim B As String
    B = "PROCESSED VIA CRM AUTOMATION"
    A = Trim(Cells(2, 1).Value)
    Debug.Print A
    Debug.Print B
    Debug.Print StrComp(A, B, vbTextCompare)
    If UCase(A) = B Then
        Debug.Print "Match"
    End If
End Sub


Public Function GetProcessedInfo() As String
    Dim lastRow As Long
    Dim SkipNext4 As Long
    Dim dataCollectionActive As Long
    Dim finalOutput As String
    Dim findWireDate As Integer
    Dim findStatus As Integer
    findStatus = 0
    findWireDate = 0
    SkipNext3 = 0
    'Debug.Print "Enter"
    dataCollectionActive = 0
    lastRow = getLastNonEmptyCol(1)
    'Debug.Print lastRow
    For I = 1 To lastRow
        If SkipNext3 <> 0 Then
            SkipNext3 = SkipNext3 + 1
            If SkipNext3 = 2 Then
                SkipNext3 = 0
                findStatus = 0
                findWireDate = 0
                dataCollectionActive = 1
                finalOutput = finalOutput & "|" & (I + 1)
                'Debug.Print finalOutput
            End If
            GoTo NextIteration
        End If
        'Debug.Print Cells(I, 1).Value
        If UCase(Trim(Cells(I, 1).Value)) Like "*PROCESSED*CRM*" Then
            'Debug.Print "findStatus Set"
            findStatus = 1
            
            'SkipNext3 = 1
        End If
        If UCase(Trim(Cells(I, 1).Value)) Like "*WIRE DATE*" And findStatus = 1 Then
            findWireDate = 1
            SkipNext3 = 1
            'Debug.Print "findStatus Set"
        End If
        If dataCollectionActive = 1 Then
            If IsEmpty(Cells(I, 1).Value) = True Then
                dataCollectionActive = 0
                'Debug.Print I
                finalOutput = finalOutput & "," & (I - 1)
                'Debug.Print finalOutput
            End If
            If I = lastRow Then
                finalOutput = finalOutput & "," & I
            End If
        End If
NextIteration:
    Next I
    
    GetProcessedInfo = finalOutput
End Function


Public Function GetNotProcessedInfo() As String
    Dim lastRow As Long
    Dim SkipNext4 As Long
    Dim dataCollectionActive As Long
    Dim finalOutput As String
    Dim findWireDate As Integer
    Dim findStatus As Integer
    findStatus = 0
    findWireDate = 0
    SkipNext3 = 0
    'Debug.Print "Enter"
    dataCollectionActive = 0
    lastRow = getLastNonEmptyCol(1)
    'Debug.Print lastRow
    For I = 1 To lastRow
        If SkipNext3 <> 0 Then
            SkipNext3 = SkipNext3 + 1
            If SkipNext3 = 2 Then
                SkipNext3 = 0
                findStatus = 0
                findWireDate = 0
                dataCollectionActive = 1
                finalOutput = finalOutput & "|" & (I + 1)
                'Debug.Print finalOutput
            End If
            GoTo NextIteration
        End If
        'Debug.Print Cells(I, 1).Value
        If UCase(Trim(Cells(I, 1).Value)) Like "*NOT*PROCESSED*" Then
            'Debug.Print "Hello"
            findStatus = 1
        End If
        If UCase(Trim(Cells(I, 1).Value)) Like "*WIRE DATE*" And findStatus = 1 Then
            findWireDate = 1
            SkipNext3 = 1
            'Debug.Print "findStatus Set"
        End If
        If dataCollectionActive = 1 Then
            If IsEmpty(Cells(I, 1).Value) = True Then
                dataCollectionActive = 0
                'Debug.Print I
                finalOutput = finalOutput & "," & (I - 1)
                'Debug.Print finalOutput
            End If
            If I = lastRow Then
                finalOutput = finalOutput & "," & I
            End If
        End If
NextIteration:
    Next I
    
    GetNotProcessedInfo = finalOutput
End Function


Function getLastNonEmptyCol(col As Long) As Long
'Finds the last non-blank cell in a single row or column

Dim lRow As Long
    
    'Find the last non-blank cell in col
    lRow = Cells(Rows.Count, col).End(xlUp).Row
    
    getLastNonEmptyCol = lRow
End Function

Sub CallFunction()
    Dim str As String
    str = GetProcessedInfo()
    Debug.Print "processed out = " & str
    str = GetNotProcessedInfo()
    Debug.Print "not processed out = " & str
    
End Sub

Sub DebugPrintArray(ByVal ArrayToBePrinted As Variant)
Dim I As Long
     Dim str As String
     If IsArray(ArrayToBePrinted) Then
          str = ""
          For I = LBound(ArrayToBePrinted, 1) To UBound(ArrayToBePrinted, 1)
               For J = LBound(ArrayToBePrinted, 2) To UBound(ArrayToBePrinted, 2)
                    str = str & " : " & ArrayToBePrinted(I, J)
               Next J
               Debug.Print str
               str = ""
           Next I
     End If
End Sub



