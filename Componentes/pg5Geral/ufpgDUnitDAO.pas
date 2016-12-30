unit ufpgDUnitDAO;

interface

uses
  SysUtils, inifiles, uspDatabase, ADODB, uspFuncoesExcel, Forms, Windows, Dialogs,
  uspClientDataSet, uspDUnitDAO, DB, uspConnectionSQLite, Classes;

type

  TfpgDUnitDAO = class(TspDUnitDAO)
  private
    FoConexao: TspDatabase;
    oConexaoSQLite: TADOConnection;
    function RetornarSelectDadosPrincipal(psNomeTabela, psSiglaCliente: string): string;
    function RetornarSelectOutrasAbas(psNomeTabela, psSiglaCliente, psID: string): string;
  public
    property FoConnectionSQLite: TADOConnection read oConexaoSQLite write oConexaoSQLite;
    function PegarDadosTeste(poCDS: TspClientDataSet; const psArquivo, psAba: string;
      psID: string = ''): boolean; override;
    class function PegarInstancia: TfpgDUnitDAO;
    class procedure DestruirInstancia;

  end;

implementation

uses
  usegRepositorio, ufpgVariaveisTestesGUI, ufpgFuncoesSQLTests;

var
  oConnectionSQLite: TspConnectionSQLite = nil;
  Instancia: TfpgDUnitDAO = nil;

class function TfpgDUnitDAO.PegarInstancia: TfpgDUnitDAO;
begin
  if not Assigned(Instancia) then
  begin
    Instancia := TfpgDUnitDAO.Create; //PC_OK
    Instancia.FoConexao := nil;
    //    Instancia.oConexaoSQLite := nil;
  end;
  result := Instancia;
end;

class procedure TfpgDUnitDAO.DestruirInstancia;
begin
  FreeAndNil(Instancia); //PC_OK
end;

// 27/10/2015 leandro.humbert SALT:186660/20/8
function TfpgDUnitDAO.PegarDadosTeste(poCDS: TspClientDataSet;
  const psArquivo, psAba: string; psID: string): boolean;
var
  sSQL: string;
  qyDados: TADOQuery;
  qyUsuario: TADOQuery;
  i: integer;
begin
  qyDados := TADOQuery.Create(nil);
  qyUsuario := TADOQuery.Create(nil);

  if not Assigned(oConnectionSQLite) then
    oConnectionSQLite := TspConnectionSQLite.Create; //PC_OK

  FoConnectionSQLite := oConnectionSQLite.ObterConnectionSQLite;

  qyDados.Connection := FoConnectionSQLite;
  qyUsuario.Connection := FoConnectionSQLite;

  try
    if psAba = 'DadosPrincipal' then
      sSQL := RetornarSelectDadosPrincipal(psArquivo + '_' + psAba, gsCliente)
    else
      sSQL := RetornarSelectOutrasAbas(psArquivo + '_' + psAba, gsCliente, psID);

    qyDados.Close;
    qyDados.SQL.Clear;
    qyDados.SQL.Add(sSQL);
    qyDados.Open;

    for i := 0 to qyDados.Fields.Count - 1 do
      poCDS.FieldDefs.Add(qyDados.Fields[i].FieldName, ftString, 150);


    poCDS.CreateDataSet;

    qyUsuario.SQL.Text := 'Select * from esajUsuarioLoginTests';
    qyUsuario.Open;

    qyDados.First;
    while not qyDados.EOF do
    begin
      poCDs.Insert;
      for i := 0 to qyDados.Fields.Count - 1 do
      begin
        poCDs.FieldByName(qyDados.Fields[i].FieldName).AsString := qyDados.Fields[i].AsString;
      end;
      poCDs.Post;
      qyDados.Next;
    end;

  finally
    result := poCDS.Active;

    FreeAndNil(qyDados);
    FreeAndNil(qyUsuario);
    if Assigned(oConnectionSQLite) then
      FreeAndNil(oConnectionSQLite); //PC_OK
  end;
end;

//jcf:format=off

function TfpgDUnitDAO.RetornarSelectDadosPrincipal(psNomeTabela, psSiglaCliente: string): string;
begin
  Result := 'select b.dsUsuario as spUsuario, a.*              ' +
            '  from ' + psNomeTabela + ' a,                    ' +
            '       esajUsuarioLoginTests b                    ' +
            ' where a.spUsuario = b.cdUsuario                  ' +
            '   and a.cdcliente = ' + QuotedStr(psSiglaCliente);
end;

function TfpgDUnitDAO.RetornarSelectOutrasAbas(psNomeTabela, psSiglaCliente, psID: string): string;
begin
  Result := 'select *                                       ' +
            '  from ' +  psNomeTabela                         +
            ' where cdcliente = ' + QuotedStr(psSiglaCliente) +
            '   and spIdTeste = ' + psID                      +
            ' order by cdvalor desc                           ';
end;

initialization

finalization
  TfpgDUnitDAO.DestruirInstancia;

end.



