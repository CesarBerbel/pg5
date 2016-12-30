unit ufpgCancRegSentencaModelTests;

interface

uses
  ufpgCancRegSentenca, ufpgModelTests, ADODB;

type
  TffpgCancRegSentencaModelTests = class(TfpgModelTests)
  private
    FsIdentificadorTesteComSentenca: string;
    FsNuProcesso: string;
  protected
  public
  published
    property fpgIdentificadorTesteComSentenca: string   
      read FsIdentificadorTesteComSentenca write FsIdentificadorTesteComSentenca;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

{ TffpgCancRegSentencaModelTests }

end.
  
