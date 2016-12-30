unit ufpgBuildNoturno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, ImgList, Buttons, TestFramework, ActnList,
  ToolWin, IniFiles, uspTestCase, ufpgGUITestCase, ufpgVariaveisTestes;

type

  TTestFunc = function(item: ITest): boolean of object;

  TTestesBuild = class(TTestCase)
  published
    procedure _Falha;
    procedure _Erro;
    procedure _Sucesso;
  end;

  TffpgBuildNoturno = class(TForm)
    Splitter1: TSplitter;
    mmLog: TMemo;
    stBar: TStatusBar;
    ActionsImages: TImageList;
    StateImages: TImageList;
    RunImages: TImageList;
    TestTree: TTreeView;
    ToolBar1: TToolBar;
    SelectAllButton: TToolButton;
    DeselectAllButton: TToolButton;
    ToolButton1: TToolButton;
    SelectFailedButton: TToolButton;
    ToolButton2: TToolButton;
    SelectCurrentButton: TToolButton;
    DeselectCurrentButton: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    RunSelectedTestButton: TToolButton;
    ToolButton5: TToolButton;
    DialogActions: TActionList;
    RunAction: TAction;
    ExitAction: TAction;
    StopAction: TAction;
    SelectAllAction: TAction;
    Alt_R_RunAction: TAction;
    DeselectAllAction: TAction;
    Alt_S_StopAction: TAction;
    SelectFailedAction: TAction;
    SelectCurrentAction: TAction;
    DeselectCurrentAction: TAction;
    SaveConfigurationAction: TAction;
    AutoSaveAction: TAction;
    RestoreSavedAction: TAction;
    ErrorBoxVisibleAction: TAction;
    HideTestNodesAction: TAction;
    HideTestNodesOnOpenAction: TAction;
    ExpandAllNodesAction: TAction;
    BreakOnFailuresAction: TAction;
    ShowTestedNodeAction: TAction;
    CopyMessageToClipboardAction: TAction;
    UseRegistryAction: TAction;
    CopyProcnameToClipboardAction: TAction;
    RunSelectedTestAction: TAction;
    GoToNextSelectedTestAction: TAction;
    GoToPrevSelectedTestAction: TAction;
    FailIfNoChecksExecutedAction: TAction;
    FailTestCaseIfMemoryLeakedAction: TAction;
    ShowTestCasesWithRunTimePropertiesAction: TAction;
    WarnOnFailTestOverrideAction: TAction;
    TestCasePropertiesAction: TAction;
    PropertyPopUpAction: TAction;
    RunSelectedTestAltAction: TAction;
    IgnoreMemoryLeakInSetUpTearDownAction: TAction;
    ReportMemoryLeakTypeOnShutdownAction: TAction;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TestTreeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: integer);
    procedure TestTreeKeyPress(Sender: TObject; var Key: char);
    procedure TestTreeClick(Sender: TObject);
    procedure TestTreeChange(Sender: TObject; Node: TTreeNode);
    procedure SelectAllActionExecute(Sender: TObject);
    procedure DeselectAllActionExecute(Sender: TObject);
    procedure SelectFailedActionExecute(Sender: TObject);
    procedure SelectCurrentActionExecute(Sender: TObject);
    procedure DeselectCurrentActionExecute(Sender: TObject);
    procedure StopActionExecute(Sender: TObject);
    procedure RunSelectedTestActionExecute(Sender: TObject);
    procedure RunActionExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure ToolButton7Click(Sender: TObject);
  private
    { Private declarations }
    FRunning: boolean;
    FStop: boolean;
    FTests: TInterfaceList;
    FSelectedTests: TInterfaceList;
    FnTotalTestes: integer;
    FnTotalSucesso: integer;
    FnTotalFalhas: integer;
    FnTotalErros: integer;
    FTotalExecucao: integer;
//    FsHoraInicio: string;
//    function StartXML: string;
//    function EndXML: string;
//    procedure AtualizarXML(pL: integer);
//    procedure SucessXML(test: ITest);
//    procedure ErrorXML(error: TTestFailure);
//    procedure FailureXML(failure: TTestFailure);
//    procedure StartSuiteXML(test: ITest);
//    procedure EndSuiteXML;
//    class function text2sgml(Text: string): string;
  public
    { Public declarations }
    procedure AtualizarStatusBar;
    procedure Executar;
    procedure MakeNodeVisible(node: TTreeNode);
    procedure SetTreeNodeImage(Node: TTReeNode; imgIndex: integer);
    function EnableTest(test: ITest): boolean;
    function DisableTest(test: ITest): boolean;
    procedure FillTestTree(RootNode: TTreeNode; ATest: ITest); overload;
    procedure FillTestTree(ATest: ITest); overload;
    procedure RunTheTest(aTest: ITest);
    procedure UpdateStatus(const fullUpdate: boolean);
    procedure UpdateNodeState(node: TTreeNode);
    procedure SetNodeState(node: TTreeNode; Enabled: boolean);
    procedure SwitchNodeState(node: TTreeNode);
    procedure UpdateTestTreeState;
    function NodeToTest(Node: TTreeNode): ITest;
    procedure OnUpdateTimer(Sender: TObject);
    function TestToNode(test: ITest): TTreeNode;
    procedure UpdateNodeImage(node: TTreeNode);
    procedure ListSelectedTests;
    function SelectedTest: ITest;
    procedure ProcessClickOnStateIcon;
    procedure ApplyToTests(root: TTreeNode; const func: TTestFunc);
    procedure EndTest(test: ITest);
    procedure StartTest(test: ITest);
    class procedure Abrir;
    procedure IniciarAplicacao;
    procedure RemoveTestesNaoRegistrados;
  end;

  TLoginTestCase = class(TfpgGUITestCase)
  public
    procedure Setup; override;
    procedure TearDown; override;
  end;

var
  ffpgBuildNoturno: TffpgBuildNoturno;
  oLoginTestCase: TLoginTestCase;
  sBuild, sArq, sClasse: string;
  sArqXML: string;
  oLogXML: TStrings;
  oColor: TColor;
  WM_PG5: word;
  oStartTime: TDateTime;

implementation

uses
  uspVerificadorTelas;

{$R *.DFM}

const

  {: Color constants for the progress bar and failure details panel }
  clOK = clGreen;
  clFAILURE = clFuchsia;
  clERROR = clRed;

  {: Indexes of the color images used in the test tree and failure list }
  imgNONE = 0;
  imgRUNNING = 1;
  imgRUN = 2;
  imgHASPROPS = 3;
  imgFAILED = 4;
  imgERROR = 5;

  {: Indexes of the images used for test tree checkboxes }
  imgDISABLED = 1;
  imgPARENT_DISABLED = 2;
  imgENABLED = 3;

procedure TffpgBuildNoturno.SetTreeNodeImage(Node: TTReeNode; imgIndex: integer);
begin
  while Node <> nil do
  begin
    if imgIndex > Node.ImageIndex then
    begin
      Node.ImageIndex := imgIndex;
      Node.SelectedIndex := imgIndex;
    end;
    if imgIndex = imgRunning then
      Node := nil
    else
      Node := Node.Parent;
  end;
end;

procedure TffpgBuildNoturno.ProcessClickOnStateIcon;
var
  HitInfo: THitTests;
  node: TTreeNode;
  PointPos: TPoint;
begin
  GetCursorPos(PointPos);
  PointPos := TestTree.ScreenToClient(PointPos);
  with PointPos do
  begin
    HitInfo := TestTree.GetHitTestInfoAt(X, Y);
    node := TestTree.GetNodeAt(X, Y);
  end;
  if (node <> nil) and (HtOnStateIcon in HitInfo) then
  begin
    SwitchNodeState(node);
  end;
end;

function TffpgBuildNoturno.SelectedTest: ITest;
begin
  if TestTree.Selected = nil then
    result := nil
  else
    result := NodeToTest(TestTree.Selected);
end;

procedure TffpgBuildNoturno.ListSelectedTests;
var
  aTest: ITest;
  aNode: TTreeNode;
begin
  FSelectedTests.Free;  //PC_OK
  FSelectedTests := nil;
  FSelectedTests := TInterfaceList.Create; //PC_OK

  aNode := TestTree.Selected;

  while Assigned(aNode) do
  begin
    aTest := NodeToTest(aNode);
    FSelectedTests.Add(aTest as ITest);
    aNode := aNode.Parent;
  end;
end;

function TffpgBuildNoturno.NodeToTest(Node: TTreeNode): ITest;
var
  idx: integer;
begin
  assert(assigned(Node));
  idx := integer(Node.Data);
  assert((idx >= 0) and (idx < FTests.Count));
  result := FTests[idx] as ITest;
end;

procedure TffpgBuildNoturno.OnUpdateTimer(Sender: TObject);
begin
  //FTimerExpired := True;
  //FUpdateTimer.Enabled := False;
end;

function TffpgBuildNoturno.TestToNode(test: ITest): TTreeNode;
begin
  assert(assigned(test));
  result := test.GUIObject as TTreeNode;
  assert(assigned(result));
end;

procedure TffpgBuildNoturno.UpdateNodeState(node: TTreeNode);
var
  test: ITest;
begin
  assert(assigned(node));
  test := NodeToTest(node);
  assert(assigned(test));

  UpdateNodeImage(node);

  if node.HasChildren then
  begin
    node := node.GetFirstChild;
    while node <> nil do
    begin
      UpdateNodeState(node);
      node := node.getNextSibling;
    end;
  end;
end;

procedure TffpgBuildNoturno.SetNodeState(node: TTreeNode; Enabled: boolean);
var
  MostSeniorChanged: TTReeNode;
begin
  assert(node <> nil);

  // update ancestors if enabling
  NodeToTest(Node).Enabled := Enabled;

  MostSeniorChanged := Node;
  if Enabled then
  begin
    while Node.Parent <> nil do
    begin
      Node := Node.Parent;
      if not NodeToTest(Node).Enabled then
      begin // changed
        NodeToTest(Node).Enabled := True;
        MostSeniorChanged := Node;
        UpdateNodeImage(Node);
      end;
    end;
  end;
  TestTree.Items.BeginUpdate;
  try
    UpdateNodeState(MostSeniorChanged);
  finally
    TestTree.Items.EndUpdate;
  end;
end;

procedure TffpgBuildNoturno.SwitchNodeState(node: TTreeNode);
begin
  assert(node <> nil);
  SetNodeState(node, not NodeToTest(node).Enabled);
end;

procedure TffpgBuildNoturno.UpdateTestTreeState;
var
  node: TTreeNode;
begin
  if TestTree.Items.Count > 0 then
  begin
    TestTree.Items.BeginUpdate;
    try
      node := TestTree.Items.GetFirstNode;
      while node <> nil do
      begin
        UpdateNodeState(node);
        node := node.getNextSibling;
      end
    finally
      TestTree.Items.EndUpdate;
    end;
  end;
end;

procedure TffpgBuildNoturno.FillTestTree(RootNode: TTreeNode; ATest: ITest);
var
  TestTests: IInterfaceList;
  i: integer;
begin

  if (ATest = nil) then
    EXIT;

  RootNode := TestTree.Items.AddChild(RootNode, ATest.Name);
  RootNode.Data := TObject(FTests.Add(ATest));
  ATest.GUIObject := RootNode;
  SetNodeState(RootNode, False);

  TestTests := ATest.Tests;
  for i := 0 to TestTests.Count - 1 do
  begin
    FillTestTree(RootNode, TestTests[i] as ITest);
  end;

  if (((oLoginTestCase.spMetodoTest = ATest.Name) or (oLoginTestCase.spSuite = ATest.Name)) or
    ((oLoginTestCase.spMetodoTest = '') and (oLoginTestCase.spSuite = ''))) and
    (ATest.Name <> '') then
  begin
    ApplyToTests(RootNode, EnableTest);
    SetNodeState(RootNode, True);
  end;

end;

procedure TffpgBuildNoturno.FillTestTree(ATest: ITest);
begin
  TestTree.Items.Clear;
  FTests.Clear;
  FillTestTree(nil, ATest);
  RemoveTestesNaoRegistrados;
end;

procedure TffpgBuildNoturno.FormCreate(Sender: TObject);
begin
  FTests := TInterfaceList.Create; //PC_OK
  oLoginTestCase := TLoginTestCase.Create; //PC_OK
  oLogXML := TStringList.Create; //PC_OK
  oColor := clBtnFace;
  FillTestTree(TestFramework.RegisteredTests);
end;

procedure TffpgBuildNoturno.FormDestroy(Sender: TObject);
begin
  oLoginTestCase.Free; //PC_OK
  FTests.Free; //PC_OK
  oLogXML.Free; //PC_OK
end;

procedure TffpgBuildNoturno.Executar;
var
  test: ITest;
  node: TTreeNode;
  i: integer;
begin
  for i := 0 to TestTree.Items.Count - 1 do
  begin
    if FStop then
      Break;
    node := TestTree.Items[i];
    node.ImageIndex := imgNONE;
    if (node.StateIndex = imgENABLED) and (node.Count = 0) then
    begin
      FnTotalTestes := FnTotalTestes + 1;
      test := NodeToTest(node);
      RunTheTest(test);
    end;
  end;
end;

procedure TffpgBuildNoturno.RunTheTest(aTest: ITest);
var
  TestResult: TTestResult;
  nErrorCount, nFailureCount: integer;
  node: TTreeNode;
begin
  if aTest = nil then
    EXIT;

  if FRunning then
    EXIT;

  FRunning := True;
  try
    node := TestToNode(aTest);
    TestResult := TTestResult.Create;
    try
      aTest.FailsOnMemoryLeak := True;
      StartTest(aTest);
      aTest.run(TestResult);
      SetTreeNodeImage(node, imgRUN);
    finally
      FTotalExecucao := FTotalExecucao + TestResult.TotalTime;
      nErrorCount := TestResult.ErrorCount;
      nFailureCount := TestResult.FailureCount;

      gbErroTest := (nErrorCount + nFailureCount) > 0;

      if nErrorCount > 0 then
        SetTreeNodeImage(node, imgERROR);

      if nFailureCount > 0 then
        SetTreeNodeImage(node, imgFAILED);

      EndTest(aTest);

      FreeAndNil(TestResult);
    end;
  finally
    FRunning := False;
  end;
end;

//procedure TffpgBuildNoturno.RunTheTest(aTest: ITest);
//var
//  TestResult: TTestResult;
//  i, ix, nErrorCount, nFailureCount: integer;
//  node: TTreeNode;
//  sStatus, sLinha: string;
//  sStrings: TStringList;
//begin
//  if aTest = nil then
//    EXIT;

//  if FRunning then
//    EXIT;

//  FRunning := True;
//  try
//    sStatus := '';
//    node := TestToNode(aTest);
//    sStrings := TStringList.Create;
//    TestResult := TTestResult.Create;
//    try
//      aTest.FailsOnMemoryLeak := True;
//      StartTest(aTest);
//      aTest.run(TestResult);
//      SetTreeNodeImage(node, imgRUN);
//    finally
//      FTotalExecucao := FTotalExecucao + TestResult.TotalTime;
//      nErrorCount := TestResult.ErrorCount;
//      nFailureCount := TestResult.FailureCount;
//      if (nErrorCount + nFailureCount) = 0 then
//      begin
//        gbErroTest := False;
//        sStatus := 'Sucesso!';
//        SucessXML(aTest);
//        FnTotalSucesso := FnTotalSucesso + 1;
//      end
//      else
//        gbErroTest := True;
//      //Classe, Teste, Erros, Falhas
//      if sClasse <> node.parent.Text then
//        mmLog.Lines.add('||' + node.parent.Text + '| | | | | | |');

//      sClasse := node.parent.Text;
//      mmLog.Lines.add(Format('|%s|%d|%d| | | | |', [aTest.Name, nErrorCount, nFailureCount]));

//      if nErrorCount > 0 then
//      begin
//        SetTreeNodeImage(node, imgERROR);
//        FnTotalErros := FnTotalErros + 1;
//        for i := 0 to nErrorCount - 1 do
//        begin
//          mmLog.Lines.add('|Erro:|' + TestResult.Errors[i].ThrownExceptionMessage + '| | | | | |');
//          mmLog.Lines.add('|Trace:|' + TestResult.Errors[i].StackTrace + '| | | | | |');
//          ErrorXML(TestResult.Errors[i]);
//        end;
//      end;
//      if nFailureCount > 0 then
//      begin
//        SetTreeNodeImage(node, imgFAILED);
//        FnTotalFalhas := FnTotalFalhas + 1;
//        for i := 0 to nFailureCount - 1 do
//        begin
//          mmLog.Lines.add('|Falha:|' + TestResult.Failures[i].ThrownExceptionMessage +
//            '| | | | | |');
//          mmLog.Lines.add('|Trace:|' + TestResult.Failures[i].StackTrace + '| | | | | |');
//          FailureXML(TestResult.Failures[i]);
//        end;
//      end;

//      EndTest(aTest);

//      //******LOG********
//      sStrings.Clear;
//      sLinha := '||Teste||Erros||Falhas||Colaborador||Status||Merge||OBS|';
//      if mmLog.Lines.IndexOf(sLinha) = -1 then
//        sStrings.Add(sLinha);
//      sStrings.Add(mmLog.Text);
//      sStrings.SaveToFile(sArq);
//      //******************

//      //******XML********
//      sStrings.Clear;
//      sLinha := '<TestRun>';
//      if oLogXML.IndexOf(sLinha) = -1 then
//        sStrings.Add(StartXML);
//      sLinha := '<Statistics>';
//      ix := oLogXML.IndexOf(sLinha);
//      if ix <> -1 then
//        AtualizarXML(ix);
//      sStrings.Add(oLogXML.Text);
//      sStrings.Add(EndXML);
//      sStrings.SaveToFile(sArqXML);
//      //******************
//      FreeAndNil(TestResult);
//      FreeAndNil(sStrings);
//    end;
//  finally
//    FRunning := False;
//  end;
//end;

procedure TffpgBuildNoturno.TestTreeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  NewNode: TTreeNode;
begin
  if (Button = mbRight) and (htOnItem in TestTree.GetHitTestInfoAt(X, Y)) then
  begin
    NewNode := TestTree.GetNodeAt(X, Y);
    if TestTree.Selected <> NewNode then
      TestTree.Selected := NewNode;
  end;
end;

procedure TffpgBuildNoturno.TestTreeKeyPress(Sender: TObject; var Key: char);
begin
  if (Key = ' ') and (TestTree.Selected <> nil) then
  begin
    SwitchNodeState(TestTree.Selected);
    UpdateStatus(True);
    Key := #0;
  end;
end;

procedure TffpgBuildNoturno.TestTreeClick(Sender: TObject);
begin
  if FRunning then
    EXIT;

  ProcessClickOnStateIcon;
  TestTreeChange(Sender, TestTree.Selected);
end;

procedure TffpgBuildNoturno.TestTreeChange(Sender: TObject; Node: TTreeNode);
var
  i: integer;
  sAux: string;
begin
  if (Node <> nil) and (Node = TestTree.Selected) then
  begin
    UpdateStatus(True);
    i := Length(Node.Text) - 50;
    if i <= 0 then
      i := 1;
    sAux := Copy(Node.Text, i, Length(Node.Text));
    stBar.Panels[1].Text := sAux;
    AtualizarStatusbar;
  end;
  setScrollPos(TestTree.Handle, SB_HORZ, 0, True);
end;

procedure TffpgBuildNoturno.UpdateStatus(const fullUpdate: boolean);
{
var
  i :Integer;
  TestNumber: Integer;

   function FormatElapsedTime(milli: Int64):string;
   var
     h,nn,ss,zzz: Cardinal;
   begin
     h := milli div 3600000;
     milli := milli mod 3600000;
     nn := milli div 60000;
     milli := milli mod 60000;
     ss := milli div 1000;
     milli := milli mod 1000;
     zzz := milli;
     Result := Format('%d:%2.2d:%2.2d.%3.3d', [h, nn, ss, zzz]);
   end;
}
begin
{
  if ResultsView.Items.Count = 0 then
    Exit;

  if fullUpdate then
  begin
    FTotalTestsCount := Suite.countEnabledTestCases;
    if Assigned(Suite) then
      ResultsView.Items[0].SubItems[0] := IntToStr(FTotalTestsCount)
    else
      ResultsView.Items[0].SubItems[0] := '';
  end;
  
  if TestResult <> nil then
  begin
    // Save the test number as we use it a lot
    TestNumber := TestResult.runCount;

    if fullUpdate or FTimerExpired or ((TestNumber and 15) = 0) then
    begin
      with ResultsView.Items[0] do
      begin
        SubItems[1] := IntToStr(TestNumber);
        SubItems[2] := IntToStr(TestResult.failureCount);
        SubItems[3] := IntToStr(TestResult.errorCount);
        SubItems[4] := IntToStr(TestResult.Overrides);
        SubItems[5] := FormatElapsedTime(TestResult.TotalTime);
        SubItems[6] := FormatElapsedTime(max(TestResult.TotalTime, FTotalTime));
      end;
      with TestResult do
      begin
        ScoreBar.Position  := TestNumber - (failureCount + errorCount);
        ProgressBar.Position := TestNumber;

        // There is a possibility for zero tests
        if (TestNumber = 0) and (Suite.CountEnabledTestCases = 0) then
          LbProgress.Caption := '100%'
        else
          LbProgress.Caption := IntToStr((100 * ScoreBar.Position) div ScoreBar.Max) + '%';
      end;
      if FTimerExpired and (TestNumber < FTotalTestsCount) then
      begin
        FTimerExpired := False;
        FUpdateTimer.Enabled := True;
      end;
    end;
    // Allow just the results pane to catch up

    ResultsPanel.Update;
  end
  else
  begin
    with ResultsView.Items[0] do
    begin
      if (SubItems[0] = '0') or (subItems[0] = '') then
      begin
        for i := 1 to 6 do
          SubItems[i] := ''
      end
      else
      begin
        if SubItems[0] <> subItems[1] then
          for i := 1 to 6 do
            SubItems[i] := ''
        else
        begin
          SubItems[5] := FormatElapsedTime(SelectedTest.ElapsedTestTime);
          SubItems[6] := FormatElapsedTime(Max(SelectedTest.ElapsedTestTime, FTotalTime));
        end;
      end;
    end;

    ResetProgress;
  end;

  if fullUpdate then
  begin
    // Allow the whole display to catch up and check for key strokes

    Update;
    Application.ProcessMessages;
  end;
}
end;

procedure TffpgBuildNoturno.UpdateNodeImage(node: TTreeNode);
var
  test: ITest;
begin
  test := NodeToTest(node);
  if not test.Enabled then
  begin
    node.StateIndex := imgDISABLED;
  end
  else
  if (node.Parent <> nil) and (node.Parent.StateIndex <= imgPARENT_DISABLED) then
  begin
    node.StateIndex := imgPARENT_DISABLED;
  end
  else
  begin
    node.StateIndex := imgENABLED;
  end;
end;

procedure TffpgBuildNoturno.SelectAllActionExecute(Sender: TObject);
begin
  ApplyToTests(TestTree.Items.GetFirstNode, EnableTest);
  UpdateStatus(True);
end;

procedure TffpgBuildNoturno.DeselectAllActionExecute(Sender: TObject);
begin
  ApplyToTests(TestTree.Items.GetFirstNode, DisableTest);
  UpdateStatus(True);
end;

procedure TffpgBuildNoturno.SelectFailedActionExecute(Sender: TObject);
{ var
  i: integer;
  ANode: TTreeNode; }
begin
  { deselect all }
  //ApplyToTests(TestTree.Items[0], DisableTest);

  { select failed }
  {
  for i := 0 to FailureListView.Items.Count - 1 do
  begin
    ANode := TTreeNode(FailureListView.Items[i].Data);
    SetNodeState(ANode, true);
  end;
  UpdateStatus(True);
  }
end;

procedure TffpgBuildNoturno.SelectCurrentActionExecute(Sender: TObject);
begin
  ApplyToTests(TestTree.Selected, EnableTest);
  SetNodeState(TestTree.Selected, True);
  UpdateStatus(True);
end;

procedure TffpgBuildNoturno.DeselectCurrentActionExecute(Sender: TObject);
begin
  ApplyToTests(TestTree.Selected, DisableTest);
  UpdateStatus(True);
end;

procedure TffpgBuildNoturno.StopActionExecute(Sender: TObject);
begin
  FStop := True;
end;

procedure TffpgBuildNoturno.RunSelectedTestActionExecute(Sender: TObject);
var
  test: ITest;
  node: TTreeNode;
begin
  FStop := False;
  node := TestTree.Selected;
  node.ImageIndex := imgNONE;
  if (node.StateIndex = imgENABLED) and (node.Count = 0) then
  begin
    gbErroTest := False;
    test := NodeToTest(node);
    RunTheTest(test);
  end;
end;

procedure TffpgBuildNoturno.RunActionExecute(Sender: TObject);
begin
  //Inicializar - Login, Verificador Telas
  IniciarAplicacao;
  sClasse := '';
  FStop := False;
  FnTotalFalhas := 0;
  FnTotalErros := 0;
  FnTotalSucesso := 0;
  FnTotalTestes := 0;
  FTotalExecucao := 0;

  sArq := ExtractFilePath(Application.ExeName) + 'tests\output\' + 'PG5AppTestsReports.txt';
  //logTest' + FormatDateTime('ddmmyyhhnn', Now) + '.txt';
  sArqXML := ExtractFilePath(Application.ExeName) + 'PG5AppTestsReports.xml';
  //logTest' + FormatDateTime('ddmmyyhhnn', Now) + '.xml';

  if FileExists(sArq) then
    mmLog.Lines.LoadFromFile(sArq);
  if FileExists(sArqXML) then
    oLogXML.LoadFromFile(sArqXML);
  Executar;
end;

procedure TffpgBuildNoturno.ApplyToTests(root: TTreeNode; const func: TTestFunc);

  procedure DoApply(rootnode: TTreeNode);
  var
    test: ITest;
    node: TTreeNode;
  begin
    if rootnode <> nil then
    begin
      test := NodeToTest(rootnode);
      if func(test) then
      begin
        node := rootnode.GetFirstChild;
        while node <> nil do
        begin
          DoApply(node);
          node := node.getNextSibling;
        end;
      end;
    end;
  end;

begin
  TestTree.Items.BeginUpdate;
  try
    DoApply(root)
  finally
    TestTree.Items.EndUpdate
  end;
  UpdateTestTreeState;
end;

function TffpgBuildNoturno.DisableTest(test: ITest): boolean;
begin
  test.Enabled := False;
  result := True;
end;

function TffpgBuildNoturno.EnableTest(test: ITest): boolean;
begin
  test.Enabled := True;
  result := True;
end;

class procedure TffpgBuildNoturno.Abrir;
var
  oIni: TIniFile;
begin
  oIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'spCFG.INI');
  sBuild := UpperCase(oIni.ReadString('DUNIT', 'BUILD', BUILD_DELPHI));

  ffpgBuildNoturno := TffpgBuildNoturno.Create(nil);

  try
    ffpgBuildNoturno.ShowModal;
  finally
    FreeAndNil(oIni);
    FreeAndNil(ffpgBuildNoturno);
  end;
end;

procedure TffpgBuildNoturno.IniciarAplicacao;
begin
  //  oLoginTestCase.IniciarAplicacao;
end;

procedure TffpgBuildNoturno.StartTest(test: ITest);
var
  node: TTreeNode;
begin
//  StartSuiteXML(test);
  assert(assigned(test));
  node := TestToNode(test);
  assert(assigned(node));
  SetTreeNodeImage(node, imgRunning);
  node.Selected := True;
  if ShowTestedNodeAction.Checked then
  begin
    MakeNodeVisible(node);
    TestTree.Update;
  end;
  UpdateStatus(False);


  setScrollPos(TestTree.Handle, SB_HORZ, 0, True);
end;

procedure TffpgBuildNoturno.MakeNodeVisible(node: TTreeNode);
begin
  node.MakeVisible;
end;

procedure TffpgBuildNoturno.EndTest(test: ITest);
begin
//  EndSuiteXML;
  UpdateStatus(False);
  AtualizarStatusBar;
end;

{ TTestesBuild }

procedure TTestesBuild._Erro;
begin
  raise Exception.Create('Erro - Tests Build');
end;

procedure TTestesBuild._Falha;
begin
  check(False, 'Falha - Tests Build');
end;

procedure TTestesBuild._Sucesso;
begin
  check(True);
end;

{ TLoginTestCase }

procedure TLoginTestCase.Setup;
begin
  //inherited;
end;

procedure TLoginTestCase.TearDown;
begin
  //inherited;
end;

procedure Mensagem(pMensagem: string; pM, pH, pHd: integer);
var
  wValor: word;
  p: PAnsiChar;
  s: string;
begin
  s := pMensagem;
  p := PAnsiChar(s);
  wValor := GlobalAddAtom(p);
  SendMessage(pH, pM, pHd, wValor);
  GlobalDeleteAtom(wValor);
end;

procedure TffpgBuildNoturno.FormShow(Sender: TObject);
var
  sSuite: string;
  hd: integer;
  s: TStringList;

  procedure SelecionarSuite(psSuite: string);
  var
    i: integer;
  begin
    DeselectAllAction.Execute;
    for i := 0 to TestTree.items.Count - 1 do
    begin
      if TestTree.items[i].Text = psSuite then
      begin
        TestTree.Selected := TestTree.items[i];
        SelectCurrentAction.Execute;
      end;
    end;
  end;

begin
  Left := 30;
  Top := 0;
  Height := Screen.Height;
  hd := FindWindow('TfBuildNoturno', nil);
  Mensagem('Iniciou!', WM_PG5, handle, hd);
  s := TStringList.Create;
  sSuite := Trim(ParamStr(1));
  if (sBuild = BUILD_NOTURNO) and (sSuite <> '') then
  begin
    try
      SelecionarSuite(sSuite);
      RunAction.Execute;
    finally
      //Application.Terminate;
      Mensagem('Finalizar', WM_PG5, handle, hd);
      s.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Finalizar.txt');
      s.Free;
    end;
  end;

end;

//function TffpgBuildNoturno.StartXML: string;
//begin
//  result := '<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>' + chr(13);
//  result := result + '<TestRun>';
//end;

//procedure TffpgBuildNoturno.AtualizarXML(pL: integer);
//var
//  sLinha: string;
//  n: integer;
//begin
//  //FnTotalTestes
//  sLinha := oLogXML.Strings[pL + 1];
//  sLinha := Copy(sLinha, 28, Length(sLinha));
//  sLinha := Copy(sLinha, 1, Pos('"', sLinha) - 1);
//  try
//    n := StrToInt(sLinha);
//  except
//    n := 0;
//  end;
//  FnTotalTestes := FnTotalTestes + n;
//
//  //FnTotalFalhas
//  sLinha := oLogXML.Strings[pL + 2];
//  sLinha := Copy(sLinha, 31, Length(sLinha));
//  sLinha := Copy(sLinha, 1, Pos('"', sLinha) - 1);
//  try
//    n := StrToInt(sLinha);
//  except
//    n := 0;
//  end;
//  FnTotalFalhas := FnTotalFalhas + n;
//
//  //FnTotalErros
//  sLinha := oLogXML.Strings[pL + 3];
//  sLinha := Copy(sLinha, 29, Length(sLinha));
//  sLinha := Copy(sLinha, 1, Pos('"', sLinha) - 1);
//  try
//    n := StrToInt(sLinha);
//  except
//    n := 0;
//  end;
//  FnTotalErros := FnTotalErros + n;
//
//  //FsHoraInicio
//  sLinha := oLogXML.Strings[pL + 6];
//  sLinha := Copy(sLinha, 34, Length(sLinha));
//  sLinha := Copy(sLinha, 1, Pos('"', sLinha) - 1);
//  FsHoraInicio := sLinha;
//
//  for n := 1 to 9 do
//    oLogXML.Delete(pL);
//end;
//
//function TffpgBuildNoturno.EndXML: string;
//var
//  nTaxaSucesso: integer;
//begin
//
//  if ((FnTotalFalhas <> 0) or (FnTotalErros <> 0)) then
//    nTaxaSucesso := 100 - ((FnTotalFalhas + FnTotalErros) * 100 div FnTotalTestes)
//  else
//    nTaxaSucesso := 100;
//
//  result := '<Statistics>' + chr(13);
//  result := result + '<Stat name="Tests" result="' + IntToStr(FnTotalTestes) + '" />' + chr(13);
//  result := result + '<Stat name="Failures" result="' + IntToStr(FnTotalFalhas) + '" />' + chr(13);
//  result := result + '<Stat name="Errors" result="' + IntToStr(FnTotalErros) + '" />' + chr(13);
//  result := result + '<Stat name="Success Rate" result="' + IntToStr(nTaxaSucesso) +
//    '%" />' + chr(13);
//  result := result + '<Stat name="Finished At" result="' + DateTimeToStr(now) + '" />' + chr(13);
//  result := result + '<Stat name="Started  At" result="' + FsHoraInicio + '" />' + chr(13);
//  result := result + '</Statistics>' + chr(13);
//  result := result + '</TestRun>';
//
//end;
//
//procedure TffpgBuildNoturno.SucessXML(test: ITest);
//var
//  Node: TTreeNode;
//  sName: string;
//begin
//  Node := TestToNode(test);
//  sName := Node.Text;
//  while Node.Parent <> nil do
//  begin
//    Node := Node.parent;
//    sName := Node.Text + '.' + sName;
//  end;
//  oLogXML.add('<Test name="' + sName + '" result="PASS">');
//  oLogXML.add('</Test>');
//end;
//
////procedure TffpgBuildNoturno.ErrorXML(error: TTestFailure);
////begin
////  oLogXML.add('<Test name="' + error.FailedTest.GetName + '" result="ERROR">');
////  oLogXML.add('<FailureType>' + error.ThrownExceptionName + '</FailureType>');
////  oLogXML.add('<Location>' + error.LocationInfo + '</Location>');
////  oLogXML.add('<Message>' + text2sgml(error.ThrownExceptionMessage) + '</Message>');
////  oLogXML.add('</Test>');
////end;
//
//procedure TffpgBuildNoturno.FailureXML(failure: TTestFailure);
//begin
//  oLogXML.add('<Test name="' + failure.FailedTest.GetName + '" result="FAILS">');
//  oLogXML.add('<FailureType>' + failure.ThrownExceptionName + '</FailureType>');
//  oLogXML.add('<Location>' + failure.LocationInfo + '</Location>');
//  oLogXML.add('<Message>' + text2sgml(failure.ThrownExceptionMessage) + '</Message>');
//  oLogXML.add('</Test>');
//
//end;
//
//procedure TffpgBuildNoturno.StartSuiteXML(test: ITest);
//begin
//  oLogXML.add('<TestSuite name="' + test.Name + '">');
//  oStartTime := now;
//  if FsHoraInicio = '' then
//    FsHoraInicio := DateTimeToStr(oStartTime);
//end;
//
//procedure TffpgBuildNoturno.EndSuiteXML;
//begin
//  oLogXML.add('</TestSuite>');
//end;

//class function TffpgBuildNoturno.text2sgml(Text: string): string;
//begin
//  Text := stringreplace(Text, '<', '&lt;', [rfReplaceAll]);
//  Text := stringreplace(Text, '>', '&gt;', [rfReplaceAll]);
//  result := Text;
//end;

procedure TffpgBuildNoturno.stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
  with stBar.Canvas do
  begin
    //Panel.Index := nPainel;
    Brush.Color := oColor;
    FillRect(Rect);
  end;
end;

procedure TffpgBuildNoturno.ToolButton7Click(Sender: TObject);
begin
  if ToolButton7.Tag = 0 then
  begin
    ToolButton7.tag := 1;
    TestTree.FullExpand;
  end
  else
  begin
    ToolButton7.tag := 0;
    TestTree.FullCollapse;
  end;
end;

procedure TffpgBuildNoturno.AtualizarStatusBar;
begin
  case testTree.Selected.ImageIndex of
    0: oColor := clBtnFace;
    1: oColor := clBlue;
    2: oColor := clLime;
    3: oColor := clYellow;
    4: oColor := $000080FF;
    5: oColor := clRed;
  end;
  stBar.Repaint;
end;

procedure TffpgBuildNoturno.RemoveTestesNaoRegistrados;

  function PodeExcluir(PNodo: TTreeNode): boolean;
  var
    i: integer;
  begin
    result := PNodo.Count > 0;
    if result then
    begin
      for i := PNodo.Count - 1 downto 0 do
        PodeExcluir(PNodo.Item[i]);

      result := PNodo.Count = 0;
    end
    else
    begin
      result := PNodo.Text = '';
    end;
    if result then
      PNodo.Delete;
  end;

begin
  PodeExcluir(TestTree.Items[0]);
end;


initialization
  WM_PG5 := RegisterWindowMessage('BuildPG5');
  //    RegisterTest('Build',TTestesBuild.Suite);

end.

