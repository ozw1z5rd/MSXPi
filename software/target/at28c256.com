>�!,
����*:���!�:����!�:����:��� !D	��
��!5�!ͭͤ!��:��:ͤ:�>(:�����������ʴ� @�S	���:͗�����W|�(�E!� �~��ͻ��#���(�����:���!v
�>��&�=� ���!n�(!��:��:ͤ�:�&@�$ :�&��$ �:B�&@�$ :C�&��$ ��g͍���z��: @G:�>7�:@G:�>7�:@G:�>7����I�����: @�A7>�:@�T7>�:@�C7>�7?�: @2:@2:@2�:2 @:2@:2@�:�����! @>Aw#�&>Tw#�&>Cw�&�����!$���[	O:�.(>�2U�>U2�j>�2U�y�S	����������� �!M��!@ '� �� � ! "!+"3"5"7��~� (�
 ��>
0͗>͗#�����_���͈�{�͈���8�|(�t(�O �!��	�怱�O�|(�t ����
870�͗����_� �����!����ͽ>.͗ͽ�~#� (͗���!6 # ��!6 
 ����:��� 	:���2��:���((�($� �<O !��	~怱2��O��y(��2��>��!� ~�7�O #�	6 ���8#��|8:�� �T��*�:����!� ~��#~� �+~�  �#"�2�Å>�2�2��~� (�(	O� #�� �2�OG���"7?�� �:�<2��� �7�~�7�� 7?�#�>�2U�>U2�j>�2U��&�>�2U�>U2�j>�2U�>�2U�>U2�j> 2U��&�>�2U�>U2�j>�2U�>�2U�>U2�j>2U��&��,�/����������x� �ɯ2�!����*��"�~�0��0G#"~�(� (�08~#"�0Ox�'�'�'�'�Gx2�2��͔!� ���*��"~�/��#~+�:  ~##�a8�a�A8<O�y��~�. #2���~�(�/(� (�.(	#�"�> �"ɯ2�:���>�2�������D8�͑�2�:���!D	�!��������>>2��!)�:��(G���:>.͗�x��/�/�:ͤ��: @�A7 :@�B(7�������͑ͤ���! @ͥ!@ͥͤ�����~�:> �͗�#����>2�!�	��&�����&*@"!�"@�&�& !�~#x� ��&�����>�A�W��  Erasing the EEPROM... Slot  Checking slot  Searching for EEPROM
 Found writable memory in slot  Found writable memory but its not the eeprom in slot  
 EEPROM not found in slot  Writing file to EEPROM in slot  Completed.
 Filename is empty or not valid
 Error opening file
 File not found
 Reading file from disk: Error reading data from file
 End of file
 No command line parameters passed
 Filename:
 Returning to MSX-DOS
 File name not specified
 Disabling AT28C256 Software Data Protection on slot: Enabling AT28C256 Software Data Protection on slot: 
Error - parameter /s <slot> must come first or it is missing
 
Error - missing parameter /s <slot> before parameter /dx
 
Error - missing parameter /s <slot> before parameter /ex
 
Patching ROM. Use ESC to bypass ROM boot
 AT28C256 EEPROM Programmer for MSX v1.2
(c) Ronivon Costa, 2020-2023

 
Write process completed
 To force disabling the AT28C256 Software Data Protction (SDP),
call this program passing the slot as parameter.
Must specify two digits for the slot, as for example:
at28csdp 01

Afterwards, you can use verrom.com to verify if the SDP was correctly disable.
 Invalid parameters
Command line options: at28c256 </h | /i> | </s <slot> </f> file.rom>

/h Show this help
/s <slot number>
/i Show initial 24 bytes of the slot cartridge
/p Patch rom to skip boot when pressing ESC (Dangerous)
/e Erase the EEPROM
/f File name with extension, for example game.rom
 h =help =i �s Ip �f �e z =  �����            ��.       �     filenameext                            