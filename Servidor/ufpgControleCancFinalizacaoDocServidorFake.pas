unit ufpgControleCancFinalizacaoDocServidorFake;

interface

uses
  SysUtils, Classes, ufpgControleCancFinalizacaoDocServidor, DB, DBClient,
  ufpgDadosDocumentoEmitido, ADODB, uspClientDataSet;

type
  TfpgControleCancFinalizacaoDocServidorFake = class(TfpgControleCancFinalizacaoDocServidor)
  protected
    function ConsultarDadosAtualizadosDocumentos(const psCdDocumentos: WideString): olevariant;
      override;
    procedure CancelarFinalizacaoDocumento(poDocumento: TfpgDadosDocumentoEmitido;
      const pbPeloEditor: boolean); override;
    procedure AbrirTransacaoCancelamento; override;
    procedure ExecutarCommitOperacaoCancelamento; override;
    procedure ExecutarRollbackOperacaoCancelamento; override;
    procedure MoverObjetoParaFilaEmElaboracao(poDocumento: TfpgDadosDocumentoEmitido); override;
  end;

implementation

uses
  uspDUnitDAO, usajConstante, uspFuncoesExcel, uspFuncoesSql, uspFuncoesString;

function TfpgControleCancFinalizacaoDocServidorFake.ConsultarDadosAtualizadosDocumentos(
  const psCdDocumentos: WideString): olevariant;
var
  oQuery: TADOQuery;
  cdsDados: TspClientDataSet;
  slDocumentos: TStringList;
  i: integer;
  sFiltro: string;
begin
  cdsDados := TspClientDataSet.Create(nil);
  oQuery := TADOQuery.Create(nil);
  slDocumentos := TStringList.Create;
  try
    TspDUnitDAO.PegarInstancia.PegarDadosExcel(oQuery,
      'fpgControleCancelamentoFinalizacaoTests.xls',
      'DadosTeste', STRING_INDEFINIDO);

    slDocumentos.commaText := psCdDocumentos;
    sFiltro := STRING_INDEFINIDO;
    for i := 0 to slDocumentos.Count - 1 do
      AppendStrCSV(sFiltro, slDocumentos[i]);
    ConverterAdoQueryParaDataSet(oQuery, cdsDados);

    cdsDados.Filter := 'CDDOCUMENTO IN (' + sFiltro + ')';
    cdsDados.Filtered := True;
    result := cdsDados.spDadosFiltrados;
  finally
    FreeAndNil(cdsDados);
    FreeAndNil(oQuery);
    FreeAndNil(slDocumentos);
  end;
end;

procedure TfpgControleCancFinalizacaoDocServidorFake.CancelarFinalizacaoDocumento(
  poDocumento: TfpgDadosDocumentoEmitido; const pbPeloEditor: boolean);
begin
  Exit;
end;

procedure TfpgControleCancFinalizacaoDocServidorFake.AbrirTransacaoCancelamento;
begin
  Exit;
end;

procedure TfpgControleCancFinalizacaoDocServidorFake.ExecutarCommitOperacaoCancelamento;
begin
  Exit;
end;

procedure TfpgControleCancFinalizacaoDocServidorFake.ExecutarRollbackOperacaoCancelamento;
begin
  Exit;
end;

procedure TfpgControleCancFinalizacaoDocServidorFake.MoverObjetoParaFilaEmElaboracao(
  poDocumento: TfpgDadosDocumentoEmitido);
begin
  Exit;
end;

end.

