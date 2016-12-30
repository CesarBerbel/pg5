unit ufpgControleTelaCadProcessoTests;

interface

uses
  ufpgControleTelaCadProcesso, TestFrameWork, Windows, Forms, FutureWindows,
  SysUtils, Controls, usajClasse1GrauCons, uspConsulta, uspDbCheckBox,
  uccpNumeroGuiaFake, uspClientDataSet, Classes, DB, uspTestCase;

type
  TfpgControleTelaCadProcessoTests = class(TspTestCase)
  private
    FoControleTela: TfpgControleTelaCadProcesso;
    FoForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarHabilitarComponentePeloComportamentoDeOutro;
    procedure TestarTestarAlteracaoAssuntosPorCodigo;
    procedure TestarTestarAlteracaoDeAssuntos;
    procedure TestarPosicionarComponente;
  end;

implementation

//27/05/2013 - DAVID - SALT: 108323/1
procedure TfpgControleTelaCadProcessoTests.SetUp;
begin
  FoControleTela := TfpgControleTelaCadProcesso.Create(); //PC_OK
  FoForm := TForm.Create(nil); //PC_OK
  inherited;
end;

//27/05/2013 - DAVID - SALT: 108323/1
procedure TfpgControleTelaCadProcessoTests.TearDown;
begin
  FoForm.Free; //PC_OK
  FoControleTela.Free; //PC_OK
  inherited;
end;

//27/05/2013 - DAVID - SALT: 108323/1
procedure TfpgControleTelaCadProcessoTests.TestarHabilitarComponentePeloComportamentoDeOutro;
var
  oDBCheckBox: TspDBCheckBox;
  oNumeroGuia: TccpNumeroGuiaFake;
begin
  oDBCheckBox := TspDBCheckBox.Create(nil);
  oNumeroGuia := TccpNumeroGuiaFake.Create(nil);
  try
    oDBCheckBox.parent := FoForm;
    oNumeroGuia.parent := FoForm;
    oDBCheckBox.Checked := True;
    FoControleTela.HabilitarComponentePeloComportamentoDeOutro(oDBCheckBox, oNumeroGuia);
    CheckFalse(oNumeroGuia.Enabled);
    oDBCheckBox.Checked := False;
    FoControleTela.HabilitarComponentePeloComportamentoDeOutro(oDBCheckBox, oNumeroGuia);
    CheckTrue(oNumeroGuia.Enabled);
  finally
    oDBCheckBox.Free;
    oNumeroGuia.Free;
  end;
end;

//27/05/2013 - DAVID - SALT: 108323/1
procedure TfpgControleTelaCadProcessoTests.TestarPosicionarComponente;
var
  osajClasse1GrauCons: TsajClasse1GrauCons;
begin
  osajClasse1GrauCons := TsajClasse1GrauCons.Create(nil);
  try
    FoControleTela.PosicionarComponente(osajClasse1GrauCons, FoForm, 0, 2, 5, 211, 130);

    CheckTrue(osajClasse1GrauCons.Parent = FoForm);
    CheckTrue(osajClasse1GrauCons.TabOrder = 0);
    CheckTrue(osajClasse1GrauCons.Top = 2);
    CheckTrue(osajClasse1GrauCons.Left = 5);
    CheckTrue(osajClasse1GrauCons.Width = 211);
    CheckTrue(osajClasse1GrauCons.spWidthDesc = 130);
  finally
    osajClasse1GrauCons.Free;
  end;
end;

//27/05/2013 - DAVID - SALT: 108323/1
procedure TfpgControleTelaCadProcessoTests.TestarTestarAlteracaoAssuntosPorCodigo;
var
  nCdAssuntoPrinc: integer;
  nCdAssuntoCompl: integer;
  oCds: TspClientDataSet;
begin
  nCdAssuntoPrinc := 001;
  nCdAssuntoCompl := 003;
  oCds := TspClientDataSet.Create(nil);
  try
    ocds.FieldDefs.Add('cdAssunto', ftInteger, 0);
    ocds.FieldDefs.Add('cdAssuntoCompl', ftInteger, 0);
    ocds.CreateDataSet;
    ocds.Active := True;

    AppendStringList(ocds, '001,002');

    if (not oCds.IsEmpty) then
      CheckTrue(FoControleTela.TestarAlteracaoAssuntosPorCodigo(nCdAssuntoPrinc,
        nCdAssuntoCompl, oCds));

    oCds.EmptyDataSet;

    AppendStringList(ocds, '001,003');

    if (not oCds.IsEmpty) then
      CheckFalse(FoControleTela.TestarAlteracaoAssuntosPorCodigo(nCdAssuntoPrinc,
        nCdAssuntoCompl, oCds));
  finally
    oCds.Free;
  end;
end;

//27/05/2013 - DAVID - SALT: 108323/1
procedure TfpgControleTelaCadProcessoTests.TestarTestarAlteracaoDeAssuntos;
var
  oCdsA: TspClientDataSet;
  oCdsB: TspClientDataSet;
begin
  oCdsA := TspClientDataSet.Create(nil);
  oCdsB := TspClientDataSet.Create(nil);
  try
    ocdsA.FieldDefs.Add('cdAssunto', ftFloat, 0);
    ocdsA.FieldDefs.Add('cc_cdAssuntoExt', ftFloat, 0);
    ocdsA.FieldDefs.Add('cc_deAssuntoConsulta', FtString, 120);
    ocdsA.FieldDefs.Add('cdAssuntoCompl', ftFloat, 0);
    ocdsA.FieldDefs.Add('cc_deAssuntoCompl', FtString, 120);
    ocdsA.CreateDataSet;
    ocdsA.Active := True;

    TfpgControleTelaCadProcessoTests.AppendStringList(ocdsA,
      '001,002,"Descricao Assunto Consulta", 003, "Descricao Assunto Complementar"');

    ocdsB.FieldDefs.Add('cdAssunto', ftFloat, 0);
    ocdsB.FieldDefs.Add('cc_cdAssuntoExt', ftFloat, 0);
    ocdsB.FieldDefs.Add('cc_deAssuntoConsulta', FtString, 120);
    ocdsB.FieldDefs.Add('cdAssuntoCompl', ftFloat, 0);
    ocdsB.FieldDefs.Add('cc_deAssuntoCompl', FtString, 120);
    ocdsB.CreateDataSet;
    ocdsB.Active := True;

    TfpgControleTelaCadProcessoTests.AppendStringList(ocdsB,
      '001,003,"Descricao Assunto Consulta", 003, "Descricao Assunto Complementar"');

    if (not oCdsA.IsEmpty) and (not oCdsB.IsEmpty) then
      CheckTrue(FoControleTela.TestarAlteracaoDeAssuntos(oCdsA, oCdsB));

    oCdsB.EmptyDataSet;

    TfpgControleTelaCadProcessoTests.AppendStringList(ocdsB,
      '001,002,"Descricao Assunto Consulta", 003, "Descricao Assunto Complementar"');

    if (not oCdsA.IsEmpty) and (not oCdsB.IsEmpty) then
      CheckFalse(FoControleTela.TestarAlteracaoDeAssuntos(oCdsA, oCdsB));
  finally
    oCdsA.Free;
    oCdsB.Free;
  end;
end;

initialization
  TestFrameWork.RegisterTest('Unitário\PG5\Classes\ufpgControleTelaCadProcessoTests',
    TfpgControleTelaCadProcessoTests.Suite);

end.

