unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type
  TRGBForm = class(TForm)
    Label1: TLabel;
    OrigImage: TImage;
    Label2: TLabel;
    DestImage: TImage;
    RedTrackBar: TTrackBar;
    Label3: TLabel;
    REDValueLbl: TLabel;
    AboutBtn: TButton;
    GreenTrackBar: TTrackBar;
    GreenValueLbl: TLabel;
    Label5: TLabel;
    BlueTrackBar: TTrackBar;
    BlueValueLbl: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RGBForm: TRGBForm;

const
    MaxPixelCount   =  32768;

type
    pRGBArray  =  ^TRGBArray;
    TRGBArray  =  ARRAY[0..MaxPixelCount-1] OF TRGBTriple;

function Min(a, b: integer): integer;
function Max(a, b: integer): integer;

implementation

uses about;

{$R *.DFM}

procedure TRGBForm.FormCreate(Sender: TObject);
begin
  OrigImage.Picture.LoadFromFile('Delphi.bmp');
  DestImage.Picture.LoadFromFile('Delphi.bmp');

  OrigImage.Picture.Bitmap.PixelFormat := pf24bit;
  DestImage.Picture.Bitmap.PixelFormat := pf24bit;

  RedTrackBar.Position := 0;
  RedValueLbl.Caption := '0';
  GreenTrackBar.Position := 0;
  GreenValueLbl.Caption := '0';
  BlueTrackBar.Position := 0;
  BlueValueLbl.Caption := '0';
end;

procedure TRGBForm.TrackBarChange(Sender: TObject);
var i, j, RedValue, GreenValue, BlueValue: integer;
    OrigRow, DestRow: pRGBArray;
begin
    // get brightness increment value
  RedValue := RedTrackBar.Position;
  GreenValue := GreenTrackBar.Position;
  BlueValue := BlueTrackBar.Position;

  if RedValue <= 0 then REDValueLbl.Caption := IntToStr(RedValue)
  else REDValueLbl.Caption := Format('+%d', [RedValue]);
  if GreenValue <= 0 then GreenValueLbl.Caption := IntToStr(GreenValue)
  else GreenValueLbl.Caption := Format('+%d', [GreenValue]);
  if BlueValue <= 0 then BlueValueLbl.Caption := IntToStr(BlueValue)
  else BlueValueLbl.Caption := Format('+%d', [BlueValue]);

    // for each row of pixels
  for i := 0 to OrigImage.Picture.Height - 1 do
  begin
    OrigRow := OrigImage.Picture.Bitmap.ScanLine[i];
    DestRow := DestImage.Picture.Bitmap.ScanLine[i];

      // for each pixel in row
    for j := 0 to OrigImage.Picture.Width - 1 do
    begin
        // add brightness value to pixel's RGB values
      if RedValue > 0 then
        DestRow[j].rgbtRed := Min(255, OrigRow[j].rgbtRed + RedValue)
      else
        DestRow[j].rgbtRed := Max(0, OrigRow[j].rgbtRed + RedValue);

      if GreenValue > 0 then
        DestRow[j].rgbtGreen := Min(255, OrigRow[j].rgbtGreen + GreenValue)
      else
        DestRow[j].rgbtGreen := Max(0, OrigRow[j].rgbtGreen + GreenValue);

      if BlueValue > 0 then
        DestRow[j].rgbtBlue := Min(255, OrigRow[j].rgbtBlue + BlueValue)
      else
        DestRow[j].rgbtBlue := Max(0, OrigRow[j].rgbtBlue + BlueValue);

    end;
  end;

  DestImage.Repaint;
end;

function Min(a, b: integer): integer;
begin
  if a < b then result := a
  else result := b;
end;

function Max(a, b: integer): integer;
begin
  if a > b then result := a
  else result := b;
end;

procedure TRGBForm.AboutBtnClick(Sender: TObject);
begin
 AboutForm.ShowModal;
end;



end.
