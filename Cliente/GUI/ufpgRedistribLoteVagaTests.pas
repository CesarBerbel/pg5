unit ufpgRedistribLoteVagaTests;

interface

uses
  ufpgRedistribLoteVaga, ufpgGUITestCase, ufpgRedistribLoteVagaModelTests, ufpgDataModelTests;

type
  TffpgRedistribLoteVagaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRedistribLoteVaga;
    FoDados: TffpgRedistribLoteVagaModelTests;

    procedure RedistribuicaoEntreVaga;
    procedure PreencherDadosDirecionado;
    procedure PreencherDadosSorteio;
    procedure selecionarVaga;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarRedistribuicaoEntreVaga;
  end;

implementation

uses
  TestFrameWork, uspInterface, Windows, Forms, FutureWindows, SysUtils,
  usajConstante, ufpgFuncoesGUITestes, ufpgVariaveisTestesGUI, ufpgConsVaga;

{ TffpgRedistribLoteVagaTests }

function TffpgRedistribLoteVagaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRedistribLoteVagaModelTests;
end;

procedure TffpgRedistribLoteVagaTests.RedistribuicaoEntreVaga;
var
  bTestes: boolean;
begin
  FoDados := TffpgRedistribLoteVagaModelTests(spDataModelTests);
  FoDados.VerificarDadosDistProcesso(gsCdProcesso);
  if FoDados.VerificarJuizVaga(gsCdProcesso, foDados.fpgJuizProcesso, gsVaga, gsVara, gsForo) then
    Exit;
  AbrirTela;
  FoTela := TffpgRedistribLoteVaga(spTela);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  CheckTrue(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado.');

  if FoDados.fpgDistSorteio then
  begin
    PreencherDadosSorteio;
    FoDados.fpgCdVaraDestino := gsVara;
    FoDados.fpgCdVagaDestino := gsVaga;
  end
  else
    PreencherDadosDirecionado;

  FoTela.ccCadastro.Execute(acSalvar);

  FecharTela;
  bTestes := FoDados.VerificarVaraProcesso(FoDados.fpgCdVaraDestino,
    FoDados.fpgCdVagaDestino, gsCdProcesso);
  CheckTrue(bTestes, 'O processo não foi redistribuido');
end;

procedure TffpgRedistribLoteVagaTests.TestarRedistribuicaoEntreVaga;
begin
  ExecutarRoteiroTestes(RedistribuicaoEntreVaga);
end;

procedure TffpgRedistribLoteVagaTests.PreencherDadosDirecionado;
begin
  EnterTextInto(FoTela.csForo.dfCdForo, FoDados.fpgCdForoDestino);
  EnterTextInto(FoTela.csVara.dfcdVara, FoDados.fpgCdVaraDestino);
  EnterTextInto(FoTela.csVaga.dfcdVaga, FoDados.fpgCdVagaDestino);
  EnterTextInto(FoTela.dfdeMotivo.spMemo, FoDados.fpgMotivo);
  TFutureWindows.Expect('TfsajAssistente').ExecProc(FecharJanelaModal);
  EnterTextInto(FoTela.edNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
end;


procedure TffpgRedistribLoteVagaTests.PreencherDadosSorteio;
begin
  EnterTextInto(FoTela.csVara.dfcdVara, gsVara);
  selecionarVaga;
  EnterTextInto(FoTela.dfdeMotivo.spMemo, FoDados.fpgMotivo);
  TFutureWindows.Expect('TfsajAssistente').ExecProc(FecharJanelaModal);
  EnterTextInto(FoTela.edNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
end;

procedure TffpgRedistribLoteVagaTests.selecionarVaga;
var
  oTelaVaga: TffpgConsVaga;
  sVaga: string;

begin
  FoTela.csVaga.pbConsulta.Click;
  oTelaVaga := TffpgConsVaga(PegarTela('ffpgConsVaga'));

  oTelaVaga.grDados.DataSource.DataSet.First;
  while not oTelaVaga.grDados.DataSource.DataSet.EOF do
  begin
    sVaga := oTelaVaga.grDados.DataSource.DataSet.FieldByName('CDVAGA').AsString;
    if sVaga <> gsVaga then
    begin
      oTelavaga.grDados.DataSource.DataSet.Locate('CDVAGA', sVaga, []);
      oTelaVaga.ccCadastro.Execute(acSelecionar);
      gsVaga := sVaga;
      Break;
    end
    else
      oTelaVaga.grDados.DataSource.DataSet.Next;
  end;
end;

end.

