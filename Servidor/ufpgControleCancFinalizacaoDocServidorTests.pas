unit ufpgControleCancFinalizacaoDocServidorTests;

interface

uses
  SysUtils, Classes, TestFrameWork, ufpgControleCancFinalizacaoDocServidor,
  uspTestCase, ufpgControleCancFinalizacaoDocServidorFake, DB, DBClient,
  uspClientDataSet, ufpgRetornoCancFinalizacaoDocumento;

type
  TfpgControleCancFinalizacaoDocServidorTests = class(TspTestCase)
  private
    FoCtrlCancelamentoFinalizacao: TfpgControleCancFinalizacaoDocServidorFake;
    FoRetorno: TfpgRetornoCancFinalizacaoDocumento;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarCancelamentoFinalizacaoSemErros;
    procedure TestarCancelamentoSemEnviarDados;
    procedure TestarCancelamentoDocumentoAssinadoEditor;
    procedure TestarCancelamentoDocumentoNaoFinalizadoEditor;
    procedure TestarCancelamentoDocumentoJuntadoEditor;
    procedure TestarCancelamentoDocumentoAssinado;
    procedure TestarCancelamentoDocumentoJuntado;
    procedure TestarCancelamentoDocumentoNaoFinalizado;

  end;

implementation

uses
  ufpgRetornoCancFinalizacaoDocumentoItem, usajConstante;

const
  sMSG_ERRO_FINALIZADO = 'Documento não está finalizado.';
  sMSG_ERRO_ASSINADO = 'Documento está assinado.';
  sMSG_ERRO_LIBERADO_AUTOS = 'Documento está liberado nos autos.';


procedure TfpgControleCancFinalizacaoDocServidorTests.TestarCancelamentoFinalizacaoSemErros;
begin
  FoRetorno := FoCtrlCancelamentoFinalizacao.ExecutarCancelamentoFinalizacaoDocumentos(
    '1068138', False);
  ChecKTrue(FoRetorno.fpgSucessoCancelamento);
end;

procedure TfpgControleCancFinalizacaoDocServidorTests.
TestarCancelamentoDocumentoNaoFinalizadoEditor;
var
  oItem: TfpgRetornoCancFinalizacaoDocumentoItem;
begin
  FoRetorno := FoCtrlCancelamentoFinalizacao.ExecutarCancelamentoFinalizacaoDocumentos(
    '835537', True);

  CheckFalse(FoRetorno.fpgSucessoCancelamento, 'É esperado que não tenha ocorrido sucesso.');
  CheckTrue(FoRetorno.fpgItensComErro.Count > 0,
    'Não havendo sucesso, deve ter pelo menos um item de erro no retorno.');

  oItem := FoRetorno.fpgItensComErro.fpgItens[0];
  CheckTrue(oItem.fpgCdDocumento = 835537, 'O Documento com erro esperado não é esse.');
end;

procedure TfpgControleCancFinalizacaoDocServidorTests.TestarCancelamentoDocumentoAssinadoEditor;
var
  oItem: TfpgRetornoCancFinalizacaoDocumentoItem;
begin
  FoRetorno := FoCtrlCancelamentoFinalizacao.ExecutarCancelamentoFinalizacaoDocumentos(
    '1068109', True);

  CheckFalse(FoRetorno.fpgSucessoCancelamento, 'É esperado que não tenha ocorrido sucesso.');
  CheckTrue(FoRetorno.fpgItensComErro.Count > 0,
    'Não havendo sucesso, deve ter pelo menos um item de erro no retorno.');

  oItem := FoRetorno.fpgItensComErro.fpgItens[0];
  CheckTrue(oItem.fpgCdDocumento = 1068109, 'O Documento com erro esperado não é esse.');
end;

procedure TfpgControleCancFinalizacaoDocServidorTests.TestarCancelamentoDocumentoJuntadoEditor;
var
  oItem: TfpgRetornoCancFinalizacaoDocumentoItem;
begin
  FoRetorno := FoCtrlCancelamentoFinalizacao.ExecutarCancelamentoFinalizacaoDocumentos(
    '10689938', True);

  CheckFalse(FoRetorno.fpgSucessoCancelamento, 'É esperado que não tenha ocorrido sucesso.');
  CheckTrue(FoRetorno.fpgItensComErro.Count > 0,
    'Não havendo sucesso, deve ter pelo menos um item de erro no retorno.');

  oItem := FoRetorno.fpgItensComErro.fpgItens[0];
  CheckTrue(oItem.fpgCdDocumento = 10689938, 'O Documento com erro esperado não é esse.');
end;

procedure TfpgControleCancFinalizacaoDocServidorTests.TestarCancelamentoDocumentoNaoFinalizado;

begin
  FoRetorno := FoCtrlCancelamentoFinalizacao.ExecutarCancelamentoFinalizacaoDocumentos(
    '835537', False);

  CheckFalse(FoRetorno.fpgSucessoCancelamento, 'É esperado que não tenha ocorrido sucesso.');
  CheckTrue(FoRetorno.fpgItensComErro.Count > 0,
    'Não havendo sucesso, deve ter pelo menos um item de erro no retorno.');
end;

procedure TfpgControleCancFinalizacaoDocServidorTests.TestarCancelamentoDocumentoAssinado;

begin
  FoRetorno := FoCtrlCancelamentoFinalizacao.ExecutarCancelamentoFinalizacaoDocumentos(
    '1068109', False);

  CheckFalse(FoRetorno.fpgSucessoCancelamento, '?esperado que n? tenha ocorrido sucesso.');
  CheckTrue(FoRetorno.fpgItensComErro.Count > 0,
    'N? havendo sucesso, deve ter pelo menos um item de erro no retorno.');
end;

procedure TfpgControleCancFinalizacaoDocServidorTests.TestarCancelamentoDocumentoJuntado;

begin
  FoRetorno := FoCtrlCancelamentoFinalizacao.ExecutarCancelamentoFinalizacaoDocumentos(
    '10689938', False);

  CheckFalse(FoRetorno.fpgSucessoCancelamento, 'É esperado que não tenha ocorrido sucesso.');
  CheckTrue(FoRetorno.fpgItensComErro.Count > 0,
    'Não havendo sucesso, deve ter pelo menos um item de erro no retorno.');
end;


procedure TfpgControleCancFinalizacaoDocServidorTests.TestarCancelamentoSemEnviarDados;
begin
  FoRetorno := FoCtrlCancelamentoFinalizacao.ExecutarCancelamentoFinalizacaoDocumentos(
    STRING_INDEFINIDO, False);
  CheckTrue(FoRetorno.fpgSucessoCancelamento,
    'A operação deveria ter sido concluída com sucesso.');

  FoRetorno := FoCtrlCancelamentoFinalizacao.ExecutarCancelamentoFinalizacaoDocumentos(
    null, False);
  CheckTrue(FoRetorno.fpgSucessoCancelamento,
    'A operação deveria ter sido concluída com sucesso.');
end;

procedure TfpgControleCancFinalizacaoDocServidorTests.SetUp;
begin
  FoCtrlCancelamentoFinalizacao := TfpgControleCancFinalizacaoDocServidorFake.Create(nil);
  FoRetorno := nil;
end;

procedure TfpgControleCancFinalizacaoDocServidorTests.TearDown;
begin
  FreeAndNil(FoCtrlCancelamentoFinalizacao);

  if Assigned(FoRetorno) then
    FreeAndNil(FoRetorno);
end;

initialization
  TestFramework.RegisterTest('Unitário\PG5\Servidor\ufpgControleCancFinalizacaoDocServidorTests',
    TfpgControleCancFinalizacaoDocServidorTests.Suite);

end.
