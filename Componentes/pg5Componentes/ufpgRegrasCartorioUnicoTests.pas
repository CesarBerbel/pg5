unit ufpgRegrasCartorioUnicoTests;

interface

uses
  TestFrameWork, Windows, Forms, FutureWindows, SysUtils, uspTestCase,
  ufpgRegrasCartorioUnico, ufpgRegrasCartorioUnicoFake;

type
  TfpgRegrasCartorioUnicoTests = class(TspTestCase)
  private
    FoCtrlCartorioFake: TfpgRegrasCartorioUnicoFake;
  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure TestTestarUsuarioTemAcessoCartorioCartorioSemAcesso;
    procedure TestTestarUsuarioTemAcessoCartorioCartorioComAcesso;
    procedure TestTestarListaForoVaraValoresCorretos;

    procedure TestTestarPegarSequencialLotacaoCartorioDaVara;
    procedure TestTestarPegarDescricaoCartorioDaVara;
    procedure TestTestarQuantidadeRegistrosListaGruposCorreta;
    procedure TestTestarAlternarLotacaoSistemaNaoUtilizaCartorioUnico;
    procedure TestTestarAlternarLotacaoUsuarioLotadoMesmoLocal;
    procedure TestTestarAlternarLotacaoUsuarioLotadoNaLotacaoAlvo;
    procedure TestTestarAlternarLotacaoUsuarioNaoPossuiAcessoLotacao;
    procedure TestTestarAlternarLotacaoUsuarioNaoUsaCartorioUnico;
    procedure TestTestarAlternarLotacaoUsuarioNuSeqLotacaoInvalido;
    procedure TestTestarAlternarLotacaoUsuarioPossuiAcessoTipoRegraNaoSeAplica;
    procedure TestTestarAlternarLotacaoUsuarioPossuiAcessoTipoRegraSeAplicaUsuarioClicaNao;
    procedure TestTestarAlternarLotacaoUsuarioSeqLotacaoZero;
    procedure TestTestarRegistrosListaGrupoEstaoOrdemCorreta;
    procedure TestTestarAlternarLotacaoForoVaraInvalidos;
    procedure TestTestarAlternarLotacaoForoInvalido;
    procedure TestTestarAlternarLotacaoVaraInvalida;
  end;

implementation

uses
  uspFuncoesString, uspExcecao, Classes, usajConstante;

{ TfpgRegrasCartorioUnicoTests }

procedure TfpgRegrasCartorioUnicoTests.SetUp;
begin
  FoCtrlCartorioFake := TfpgRegrasCartorioUnicoFake.Create(null); //PC_OK
  FoCtrlCartorioFake.AtualizarPropriedades(nil);
  inherited;
end;

procedure TfpgRegrasCartorioUnicoTests.TearDown;
begin
  FreeAndNil(FoCtrlCartorioFake);  //PC_OK
  inherited;
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarListaForoVaraValoresCorretos;
const
  nTAM_MAX_CHAVE_FOROVARA = 7;
var
  slListaForoVara: TStringList;
  i: integer;
begin
  slListaForoVara := TStringList.Create;
  try
    slListaForoVara.commaText := FoCtrlCartorioFake.fpgListaCdForoCdVara;

    for i := 0 to slListaForoVara.Count - 1 do
      CheckTrue(length(slListaForoVara[i]) = 7);
  finally
    slListaForoVara.Clear;
    FreeAndNil(slListaForoVara);
  end;
end;


procedure TfpgRegrasCartorioUnicoTests.TestTestarQuantidadeRegistrosListaGruposCorreta;
const
  nQTD_GRUPOS = 21;
var
  slListaGrupos: TStringList;
begin
  slListaGrupos := TStringList.Create;
  try
    slListaGrupos.commaText := FoCtrlCartorioFake.fpgListaCdGrupoUsuario;

    CheckEquals(slListaGrupos.Count, nQTD_GRUPOS,
      'A lista de grupos não possui a quantidade de registros correta');
  finally
    slListaGrupos.Clear;
    FreeAndNil(slListaGrupos);
  end;
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarPegarDescricaoCartorioDaVara;
begin
  CheckTrue(FoCtrlCartorioFake.PegarDescricaoCartorioDaVara(55) = '2º_Cartorio');
  CheckTrue(FoCtrlCartorioFake.PegarDescricaoCartorioDaVara(NUMERO_INDEFINIDO) =
    STRING_INDEFINIDO);
  CheckFalse(FoCtrlCartorioFake.PegarDescricaoCartorioDaVara(NUMERO_INDEFINIDO) = '2º_Cartorio');
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarPegarSequencialLotacaoCartorioDaVara;
begin
  CheckTrue(FoCtrlCartorioFake.PegarSequencialLotacaoCartorioDaVara(2, 82) = 55);
  CheckTrue(FoCtrlCartorioFake.PegarSequencialLotacaoCartorioDaVara(NUMERO_INDEFINIDO,
    6500) = NUMERO_INDEFINIDO);
  CheckTrue(FoCtrlCartorioFake.PegarSequencialLotacaoCartorioDaVara(897,
    NUMERO_INDEFINIDO) = NUMERO_INDEFINIDO);
  CheckTrue(FoCtrlCartorioFake.PegarSequencialLotacaoCartorioDaVara(897,
    NUMERO_INDEFINIDO) = NUMERO_INDEFINIDO);
  CheckTrue(FoCtrlCartorioFake.PegarSequencialLotacaoCartorioDaVara(NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO) = NUMERO_INDEFINIDO);

  CheckTrue(FoCtrlCartorioFake.PegarSequencialLotacaoCartorioDaVara(0, 15) = NUMERO_INDEFINIDO);
  CheckTrue(FoCtrlCartorioFake.PegarSequencialLotacaoCartorioDaVara(23, 0) = NUMERO_INDEFINIDO);
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarUsuarioTemAcessoCartorioCartorioComAcesso;
begin
  CheckTrue(FoCtrlCartorioFake.TestarUsuarioTemAcessoCartorio(5, 23));
  CheckTrue(FoCtrlCartorioFake.TestarUsuarioTemAcessoCartorio(18, 23));
  CheckTrue(FoCtrlCartorioFake.TestarUsuarioTemAcessoCartorio(17, 23));
  CheckTrue(FoCtrlCartorioFake.TestarUsuarioTemAcessoCartorio(5, 42));
  CheckTrue(FoCtrlCartorioFake.TestarUsuarioTemAcessoCartorio(9, 7));
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarUsuarioTemAcessoCartorioCartorioSemAcesso;
begin
  CheckFalse(FoCtrlCartorioFake.TestarUsuarioTemAcessoCartorio(150, 12));
  CheckFalse(FoCtrlCartorioFake.TestarUsuarioTemAcessoCartorio(23, 112));
  CheckFalse(FoCtrlCartorioFake.TestarUsuarioTemAcessoCartorio(23, 218));
  CheckFalse(FoCtrlCartorioFake.TestarUsuarioTemAcessoCartorio(23, 19));
  CheckFalse(FoCtrlCartorioFake.TestarUsuarioTemAcessoCartorio(1, 5));
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarRegistrosListaGrupoEstaoOrdemCorreta;
const
  sORDEM_GRUPOS = '17,18,19,20,66666,1,2,3,4,12,5,13,6,7,8,9,10,11,14,15,16';
var
  slListaGruposMontagem: TStringList;
  slListaGruposLocal: TStringList;
  i: integer;
begin
  slListaGruposMontagem := TStringList.Create;
  slListaGruposLocal := TStringList.Create;
  try
    slListaGruposLocal.CommaText := sORDEM_GRUPOS;
    slListaGruposMontagem.commaText := FoCtrlCartorioFake.fpgListaCdGrupoUsuario;

    for i := 0 to slListaGruposMontagem.Count - 1 do
      CheckTrue((slListaGruposMontagem[i] = slListaGruposLocal[i]), 'Valor esperado na posição: ' +
        IntToStr(i) + ' foi: ' + slListaGruposMontagem[i] + '. Porém o valor obtido foi: ' +
        slListaGruposLocal[i]);
  finally
    slListaGruposLocal.Clear;
    slListaGruposMontagem.Clear;
    FreeAndNil(slListaGruposMontagem);
    FreeAndNil(slListaGruposLocal);
  end;
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarAlternarLotacaoSistemaNaoUtilizaCartorioUnico;
const
  sNU_LOTACAO = '0005489789452';
  nFORO_VALIDO = 2;
  nVARA_VALIDA = 82;
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(False);
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(nFORO_VALIDO, nVARA_VALIDA,
  //   trcuPerguntarAntesTrocarLotacao));
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarAlternarLotacaoUsuarioNaoPossuiAcessoLotacao;
const
  nCDFORO_INVALIDO = 77;
  nCDVARA_INVALIDO = 155;
  nSEQ_LOTACAO_USUARIO = 9999;
  sNU_PROCESSO = '0005489789452';
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_USUARIO;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(nCDFORO_INVALIDO, nCDVARA_INVALIDO,
  //   trcuPerguntarAntesTrocarLotacao));
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarAlternarLotacaoUsuarioLotadoNaLotacaoAlvo;
const
  nCDFORO_VALIDO = 1;
  nCDVARA_VALIDO = 3;
  nSEQ_LOTACAO_ATUAL = 5;
  sNU_PROCESSO = '0005489789452';
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(nCDFORO_VALIDO, nCDVARA_VALIDO,
  //   trcuPerguntarAntesTrocarLotacao));
end;

procedure TfpgRegrasCartorioUnicoTests.
TestTestarAlternarLotacaoUsuarioPossuiAcessoTipoRegraNaoSeAplica;
const
  nCDFORO_VALIDO = 1;
  nCDVARA_VALIDO = 3;
  nSEQ_LOTACAO_ATUAL = 544;
  sNU_PROCESSO = '0005489789452';
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(nCDFORO_VALIDO, nCDVARA_VALIDO, trcuNaoSeAplica));
end;

procedure TfpgRegrasCartorioUnicoTests.
TestTestarAlternarLotacaoUsuarioPossuiAcessoTipoRegraSeAplicaUsuarioClicaNao;
const
  nCDFORO_VALIDO = 1;
  nCDVARA_VALIDO = 3;
  nSEQ_LOTACAO_ATUAL = 544;
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
  FoCtrlCartorioFake.FbRespostaUsuarioTrocaLotacao := False;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(nCDFORO_VALIDO, nCDVARA_VALIDO,
  //   trcuPerguntarAntesTrocarLotacao));
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarAlternarLotacaoUsuarioLotadoMesmoLocal;
const
  nSEQ_LOTACAO_ATUAL = 55;
  nSEQ_LOTACAO_PROCESSO = 55;
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(nSEQ_LOTACAO_PROCESSO, trcuTrocarLotacao));
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarAlternarLotacaoUsuarioSeqLotacaoZero;
const
  nSEQ_LOTACAO_ATUAL = 55;
  nSEQ_LOTACAO_PROCESSO = 0;
  sNU_PROCESSO = '0005489789452';
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(nSEQ_LOTACAO_PROCESSO, trcuNaoSeAplica));
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarAlternarLotacaoUsuarioNaoUsaCartorioUnico;
const
  nSEQ_LOTACAO_ATUAL = 55;
  nSEQ_LOTACAO_PROCESSO = 0;
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(nSEQ_LOTACAO_PROCESSO, trcuTrocarLotacao));
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarAlternarLotacaoUsuarioNuSeqLotacaoInvalido;
const
  nSEQ_LOTACAO_ATUAL = 55;
  nSEQ_LOTACAO_PROCESSO = -999;
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(nSEQ_LOTACAO_PROCESSO, trcuTrocarLotacao));
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarAlternarLotacaoVaraInvalida;
const
  nSEQ_LOTACAO_ATUAL = 55;
  nSEQ_LOTACAO_PROCESSO = 4;
  nFORO_VALIDO = 3;
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(nFORO_VALIDO, NUMERO_INDEFINIDO,
  // trcuTrocarLotacao),
  // 'Testar se alternou lotação colocando vara inválida.');
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarAlternarLotacaoForoInvalido;
const
  nSEQ_LOTACAO_ATUAL = 55;
  nSEQ_LOTACAO_PROCESSO = 91;
  nVARA_VALIDA = 7702;
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(NUMERO_INDEFINIDO, nVARA_VALIDA,
  //   trcuTrocarLotacao),
  //   'Testando se alternou a lotação informando foro inválido.');
end;

procedure TfpgRegrasCartorioUnicoTests.TestTestarAlternarLotacaoForoVaraInvalidos;
const
  nSEQ_LOTACAO_ATUAL = 55;
  nSEQ_LOTACAO_PROCESSO = 91;
begin
  FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
  FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
  // CheckFalse(FoCtrlCartorioFake.AlternarLotacao(NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
  //   trcuTrocarLotacao), 'Testar se alternou a lotação colocando foro e vara invalidos.');
end;


// procedure TfpgRegrasCartorioUnicoTests.
// TestTestarAlternarLotacaoUsuarioPossuiAcessoTipoRegraSeAplicaTrocaLotacaoSemPergunta;
// const
//   nCDFORO_VALIDO = 1;
//   nCDVARA_VALIDO = 3;
//   nSEQ_LOTACAO_ATUAL = 544;
//   sNU_PROCESSO = '0005489789452';
// begin
//   FoCtrlCartorioFake.DefinirUtilizaCartorioUnico(True);
//   FoCtrlCartorioFake.FncdForo := nCDFORO_VALIDO;
//   FoCtrlCartorioFake.FncdVara := nCDVARA_VALIDO;
//   FoCtrlCartorioFake.FnNuSeqLotacao := nSEQ_LOTACAO_ATUAL;
//   FoCtrlCartorioFake.FbRespostaUsuarioTrocaLotacao := False;
//   CheckFalse(FoCtrlCartorioFake.AlternarLotacao(sNU_PROCESSO, trcuTrocarLotacao));
// end;

initialization
  TestFrameWork.RegisterTest(
    'Unitário\PG5\Componentes\pg5Componentes\ufpgRegrasCartorioUnicoTests',
    TfpgRegrasCartorioUnicoTests.Suite);

end.
