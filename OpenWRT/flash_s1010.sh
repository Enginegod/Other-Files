cd ~/openwrt
make -j1 V=s TARGET=ramips/mt7620 DTS=mt7620a_rostelecom_s1010 compile-dts






Блок / { virtual_flash { … } }; полностью удалён.



&spi0 {
	status = "okay";

	flash@0 {
		compatible = "jedec,spi-nor";
		reg = <0>;
		spi-max-frequency = <50000000>;
		m25p,fast-read;

		partitions {
			compatible = "fixed-partitions";
			#address-cells = <1>;
			#size-cells = <1>;

			partition@0_all {
				label = "ALL";
				reg = <0x0 0x1000000>;
				read-only;
			};

			partition@0 {
				label = "u-boot";
				reg = <0x0 0x30000>;
				read-only;
			};

			partition@30000 {
				label = "ftd_and_bootflag";
				reg = <0x30000 0x20000>;
			};

			partition@50000 {
				label = "Factory";
				reg = <0x50000 0x10000>;
				read-only;

				nvmem-layout {
					compatible = "fixed-layout";
					#address-cells = <1>;
					#size-cells = <1>;

					eeprom_factory_0: eeprom@0 {
						reg = <0x0 0x200>;
					};

					eeprom_factory_8000: eeprom@8000 {
						reg = <0x8000 0x200>;
					};
				};
			};

			partition@60000 {
				label = "SC Nvram(permanent data)";
				reg = <0x60000 0x10000>;
				read-only;

				nvmem-layout {
					compatible = "fixed-layout";
					#address-cells = <1>;
					#size-cells = <1>;

					macaddr_label: macaddr@0 {
						compatible = "mac-base";
						reg = <0x0 0x6>;
						#nvmem-cell-cells = <1>;
					};
				};
			};

			/* Один большой раздел firmware вместо двух образов */
			partition@70000 {
				label = "firmware";
				reg = <0x70000 0x8C0000>;   /* 0x70000 .. 0xFC0000 */
			};

			partition@f90000 {
				label = "MAC IP";
				reg = <0xf90000 0x10000>;
				read-only;
			};

			partition@fa0000 {
				label = "Critical Log";
				reg = <0xfa0000 0x10000>;
				read-only;
			};

			partition@fb0000 {          /* исправлено */
				label = "Critical Log Bak";
				reg = <0xfb0000 0x10000>;
				read-only;
			};

			partition@fc0000 {
				label = "Xml Config";
				reg = <0xfc0000 0x20000>;
				read-only;
			};

			partition@fe0000 {
				label = "Xml Config Bak";
				reg = <0xfe0000 0x20000>;
				read-only;
			};
		};
	};
};
