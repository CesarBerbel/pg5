unit ufpgDataModelTests;

interface

uses
  Classes, Forms, TestFrameWork, Messages, StdCtrls, Windows, Controls, SysUtils,
  uspClientDataSet, TypInfo, Dialogs, uspDataModelTests;

type

  TfpgDataModelTestsClass = class of TfpgDataModelTests;

  TfpgDataModelTests = class(TspDataModelTests)
  private
    FsIDTeste: string;
    FsMetodoTeste: string;
    FsLotacao: string;
    FsUsuario: string;
    procedure CarregarModelDinamicamente(poObjeto: TObject; poCDS: TspClientDataSet);
  public
    property spIDTeste: string read FsIDTeste write FsIDTeste;
    procedure CarregarModelTest(poCDS: TspClientDataSet); reintroduce; virtual;
  end;

implementation

{TfpgDataModelTests}

procedure TfpgDataModelTests.CarregarModelDinamicamente(poObjeto: TObject;
  poCDS: TspClientDataSet);
var
  oPPropinfo: PPropinfo;
  sCampo: string;
  i: integer;
begin
  for i := 0 to poCDS.FieldCount - 1 do
  begin
    sCampo := poCDS.FieldList[i].FullName;

    if isPublishedProp(poObjeto, sCampo) then
    begin
      oPPropinfo := GetPropInfo(poObjeto.ClassInfo, sCampo);

      if oPPropinfo^.Proptype^.Kind in [tkString, tkLString] then
        SetPropValue(poObjeto, sCampo, poCDS.FieldList[i].AsString)
      else if oPPropinfo^.Proptype^.Kind in [tkInteger] then
      begin
        if poCDS.FieldList[i].AsString = '' then
          SetPropValue(poObjeto, sCampo, 0)
        else
          SetPropValue(poObjeto, sCampo, poCDS.FieldList[i].AsInteger);
      end
      else if oPPropinfo^.Proptype^.Kind in [tkFloat] then
        SetPropValue(poObjeto, sCampo, poCDS.FieldList[i].AsFloat)
      else if oPPropinfo^.Proptype^.Kind in [tkEnumeration] then
      begin
        if poCDS.FieldList[i].AsString = 'S' then
          SetPropValue(poObjeto, sCampo, 1)
        else
          SetPropValue(poObjeto, sCampo, 0);
      end
      else
        ShowMessage('Tipo não definido.');
    end;
  end;
end;


procedure TfpgDataModelTests.CarregarModelTest(poCDS: TspClientDataSet);
begin
  if poCDS.FieldList.IndexOf('spIDTeste') <> -1 then
  begin
    FsIDTeste := poCDS.FieldByName('spIDTeste').AsString;
    if FsIDTeste = '' then
      exit;
  end;

  CarregarModelDinamicamente(self, poCDS);

  if poCDS.FieldList.IndexOf('METODO_TESTE') <> -1 then
    FsMetodoTeste := poCDS.FieldByName('METODO_TESTE').AsString;
  if poCDS.FieldList.IndexOf('LOTACAO') <> -1 then
    FsLotacao := poCDS.FieldByName('LOTACAO').AsString;
  if poCDS.FieldList.IndexOf('USUARIO') <> -1 then
    FsUsuario := poCDS.FieldByName('USUARIO').AsString;
end;

end.

