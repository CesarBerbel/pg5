unit ufpgConsProcAvancadaTests;

interface

uses
  ufpgConsProcAvancada, ufpgGUITestCase, ufpgConsProcAvancadaModelTests, ufpgDataModelTests;

type
  TffpgConsProcAvancadaTests = class(TfpgGUITestCase)
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  private
    FoTela: TffpgConsProcAvancada;
    FoDados: TffpgConsProcAvancadaModelTests;
    procedure ConsultaDeProcessoAvancada;
    procedure ConsultarPorNomeCompleto;
    procedure ConsultarPorNomeParcial;

  published
    procedure TestarConsultaProcessoAvancadaNomeCompleto;
    procedure TestarConsultaProcessoAvancadaNomeParcial;
  end;

implementation

uses
  usajConstante, Sysutils, ufpgVariaveisTestesGUI, ufpgConstanteGUITests, ufpgFuncoesGUITestes, uspInterface;

procedure TffpgConsProcAvancadaTests.TestarConsultaProcessoAvancadaNomeCompleto;
begin
  ExecutarRoteiroTestes(ConsultaDeProcessoAvancada);
end;

procedure TffpgConsProcAvancadaTests.TestarConsultaProcessoAvancadaNomeParcial;
begin
  ExecutarRoteiroTestes(ConsultaDeProcessoAvancada);
end;

function TffpgConsProcAvancadaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConsProcAvancadaModelTests;
end;

procedure TffpgConsProcAvancadaTests.ConsultaDeProcessoAvancada;
begin
  AbrirTela;
  FoTela := TffpgConsProcAvancada(spTela);
  FoDados := TffpgConsProcAvancadaModelTests(spDataModelTests);

  if FoDados.fpgConsultarNomeCompleto then
    ConsultarPorNomeCompleto
  else if FoDados.fpgConsultarNomeParcial then
    ConsultarPorNomeParcial;

  Check(FoTela.efpgProcesso.RecordCount > 0, 'O resultado esta trazendo ' +
    IntToStr(FoTela.efpgProcesso.RecordCount) + ' processo no Nome Parcial');

  FecharTela;
end;


procedure TffpgConsProcAvancadaTests.ConsultarPorNomeCompleto;
begin

  FoTela.ckNmOutraParteCompl.Checked := True;
  FoTela.ckNmRepresCompl.Checked := True;

  if FoDados.fpgNomePartePassiva = STRING_INDEFINIDO then
    FoDados.fpgNomePartePassiva := gsNomePartePassivaCPF;

  if FoDados.fpgNomeParteRepresentante = STRING_INDEFINIDO then
    FoDados.fpgNomeParteRepresentante := gsNomeParteRepresentanteCPF;

  EnterTextInto(FoTela.dfnmOutraParte, FoDados.fpgNomePartePassiva);
  EnterTextInto(FoTela.dfnmRepres, FoDados.fpgNomeParteRepresentante);
  FoTela.ccFiltro.Execute(acConsultar);
end;

procedure TffpgConsProcAvancadaTests.ConsultarPorNomeParcial;
var
  sNuProcesso: string;
begin
  FoTela.ckNmOutraParteCompl.Checked := False;
  FoTela.ckNmRepresCompl.Checked := False;

  sNuProcesso := UsarProcessoArray;
  checkFalse(sNuProcesso = STRING_INDEFINIDO, 'Número de processo não encontrado');

  EnterTextInto(FoTela.dfnmOutraParte, sNuProcesso, False);
  EnterTextInto(FoTela.dfnmRepres, sNuProcesso, False);
  FoTela.ccFiltro.Execute(acConsultar);
end;

end.

