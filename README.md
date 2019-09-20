<div>
   <p class="c29 subtitle" id="h.17dp8vu"><span class="c23">&nbsp; </span></p>
</div>

<h2 class="c32 c33" id="h.gjdgxs"><span class="c18 c36"></span></h2>
<p class="c8"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 620.50px; height: 413.67px;"><img alt="Segnaposto immagine" src="images/image14.jpg" style="width: 620.50px; height: 413.67px; margin-left: -0.00px; margin-top: -0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<h2 class="c34 title" id="h.30j0zll"><span class="c13">Driving a VGA and keyboard with Nexys 4 DDR FPGA BOARD</span></h2>

---

<p class="c10"><span class="c41">Luca Caronti, Simone Ruffini</span></p>
<p class="c32 c19"><span class="c15"></span></p>
<p class="c32"><span class="c15">University of Trento</span></p>
<p class="c32"><span class="c39">Supervisor: Prof. Roberto Passerone</span></p>

---

<p class="c45"><span class="c25 c18"><a class="c2" href="#h.w4lxkigjksng">Overview</a></span><span class="c25 c18">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c7"><span class="c26 c25"><a class="c2" href="#h.1us46n6g1bzt">Project specifics</a></span><span class="c26 c25">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c40"><span class="c5 c17"><a class="c2" href="#h.8q64rxri1pn9">Architecture specification</a></span><span class="c5 c17">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.w0ko7nd2nj93">Top level project</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.lrzz86ui9ttb">Image generator</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.by5b8vlkwiey">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.iml7vh2vamjo">Port Description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.h7se9owqbrfb">Processes</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.x29x8o50avjl">Combinational logic</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.36myif3jkmfo">Frame buffer</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.7iy0zjwf9s5h">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c18"><a class="c2" href="#h.9pxewspwovou">Port description</a></span><span class="c18">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c18"><a class="c2" href="#h.15h2zui1ill8">Processes</a></span><span class="c18">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.iyq2qdu6nld4">Editor</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.2k32ow89c4ex">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.wrav6qh9iqn">Fsm description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.5hehbjuq38j1">Port description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.mzo0sjrxk92m">Top level keyboard</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.dyaqqjjjbfgj">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.rmbum8jt8rop">Port description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.sbirudkk4fy4">VGA controller</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c0"><a class="c2" href="#h.1gf5vdqcsifq">General description</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c18"><a class="c2" href="#h.3tfi7j1kta05">Port description</a></span><span class="c18">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.5rj2yhek1o8z">Fonts ROM</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.rddv2n3biumx">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c18"><a class="c2" href="#h.szidgw1s2u73">Port description</a></span><span class="c18">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c5"><a class="c2" href="#h.ktojc5uwi11">Stream</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c5 c14"><a class="c2" href="#h.spwvkpza1zx6">General description</a></span><span class="c5 c14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c5 c14"><a class="c2" href="#h.3mis7j33on4i">Port description</a></span><span class="c5 c14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.brfb7y9sm3us">Clock wizard</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.bekf9t145y5v">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.4sgqbbhaytf8">Port description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.qz2zcm94q1er">BRAM_0</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c5 c14"><a class="c2" href="#h.rol3obkaii5l">General description</a></span><span class="c5 c14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c5 c14"><a class="c2" href="#h.wrmgkju6gas1">Port description</a></span><span class="c5 c14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c5"><a class="c2" href="#h.aft3ls9mwyn">BRAM_1</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.2hm8sd3jrkhs">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c5"><a class="c2" href="#h.b22xxw599ann">BRAM_2</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.737szcxkxgzs">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.mqvatvlrq1ks">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.8wkr24rcq9ae">Port description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.lic00sf26qiu">Keyboard driver</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.gpx64ac6vqee">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.ouiet278sgkk">Fsm description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.us5pwshrw8om">Port description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c11"><span class="c0"><a class="c2" href="#h.s4wq6u9492lr">Seven segment driver</a></span><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c4"><span class="c1"><a class="c2" href="#h.lm6rximc2bb">General description</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c40"><span class="c5 c17"><a class="c2" href="#h.hyflbz9fresj">Power summary</a></span><span class="c5 c17">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c40"><span class="c5 c17"><a class="c2" href="#h.cum3h7fekrvv">Implementation specifics</a></span><span class="c5 c17">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c7"><span class="c26 c25"><a class="c2" href="#h.hja5w8vnzs8c">Critical issues and conclusions</a></span><span class="c26 c25">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c43"><span class="c1"><a class="c2" href="#h.c9nn2tr474gv">Conclusions</a></span><span class="c1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<h1 class="c31" id="h.w4lxkigjksng"><span class="c27 c25">Overview</span></h1>
<p class="c8"><span class="c0">The project consists in managing a keyboard and display datas on a monitor through a VGA. The specifications of the VGA resolution are 640 x 480, and the US layout was chosen for the keyboard. Entire project was written in VHDL and simulated on Vivado software.</span></p>
<p class="c8"><span class="c23">All project codes are available on github at</span><span>&nbsp;</span><span class="c35"><a class="c2" href="https://www.google.com/url?q=https://github.com/lucacaronti/project_vhdl&amp;sa=D&amp;ust=1568974906611000">https://github.com/lucacaronti/project_vhdl</a></span><span class="c0">.</span></p>
<p class="c8"><span class="c0">The features of the project are the possibility to write all the available letters, up to five at the same time, to move the cursor with arrows keys through max 10 pages, to change background and text color (one is the opposite of the other) through the switches (switches from 11 to 8 are for red color, from 7 to 4 are for green and from 3 to 0 are for blu).</span></p>
<p class="c8"><span class="c23">There are also four 7-segment display that print the entered character code. &nbsp; </span></p>
<h1 class="c31" id="h.1us46n6g1bzt"><span class="c27 c25">Project specifics</span></h1>
<h2 class="c34" id="h.8q64rxri1pn9"><span class="c9">Architecture specification</span></h2>
<p class="c8"><span class="c0">The architecture is divided into 22 entities like as shown in the graph below.</span></p>
<p class="c16"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 573.50px; height: 198.27px;"><img alt="" src="images/image8.png" style="width: 573.50px; height: 198.27px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<h3 class="c7" id="h.w0ko7nd2nj93"><span class="c22 c18">Top level project</span></h3>
<p class="c8"><span class="c0">This entity has the only purpose of connecting all other entities.</span></p>
<p class="c8"><span class="c0">Moreover, a constraints file is related to this entity for physical pin connections.</span></p>
<p class="c8 c19"><span class="c0"></span></p>
<h3 class="c7" id="h.lrzz86ui9ttb"><span class="c22 c18">Image generator</span></h3>
<h4 class="c20" id="h.by5b8vlkwiey"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">Image generator is the bridge between frame buffer and the physical vga pins on the Nexys 4 DDR board. The main function is to manage requests,decoding and updates from frame buffer values into fonts rom ones that will be displayed on monitor.</span></p>
<h4 class="c20" id="h.iml7vh2vamjo"><span class="c6">Port Description</span></h4>
<ul class="c24 lst-kix_3i5itwlmfq8l-0 start">
   <li class="c3"><span class="c0">pixel_clk: master clock of the whole unit at 25MHz</span></li>
   <li class="c3"><span class="c0">resetn: main reset signal</span></li>
   <li class="c3"><span class="c0">disp_en: see vga controller disp_en</span></li>
   <li class="c3"><span class="c0">horizontal_active: see vga controller horizontal_active</span></li>
   <li class="c3"><span class="c0">vertical_active: see vga controller vertical active</span></li>
   <li class="c3"><span class="c0">cursor_rel_pos: see editor cursror_rel_pos</span></li>
   <li class="c3"><span class="c0">cursor_blink_time: see editor cursor_blink_time</span></li>
   <li class="c3"><span class="c0">data_from_frame_buffer: see frame buffer output_char_value</span></li>
   <li class="c3"><span class="c0">address_for_frame_buffer_data: is the address sent to frame_buffer where the next char to be displayed is stored</span></li>
   <li class="c3"><span class="c0">data_from_fonts_rom: see data_out fonts rom</span></li>
   <li class="c3"><span class="c0">address_for_fonts_rom_data: is the address sent to fonts rom where the bit values for that specific character are stored</span></li>
   <li class="c3"><span class="c0">VGA_R/G/B: 4 bits vectors that represent the intensity values of RGB channels that will be displayed on screen</span></li>
   <li class="c3"><span class="c0">SW: this signal comes from the built in deep switches on the Nexys Board and represents the value of the background color to be displayed such that 0 to 3, 4 to 7 and 8 to 11 are deep switches encoding such RGB value.</span></li>
</ul>
<h4 class="c20" id="h.h7se9owqbrfb"><span class="c6">Processes</span></h4>
<ul class="c24 lst-kix_s5ko05vmwr61-0 start">
   <li class="c3"><span class="c1">COUNTERS_MNGMNT</span></li>
</ul>
<p class="c8 c12"><span class="c0">This process manages input signals for 4 counters: INIT (initialization of the counter to a fixed value) and CE ( count enable).</span></p>
<p class="c8 c12"><span class="c0">When vga controller is in display time COUNTER_A can count. Since COUNTER_A is activated, subsequent counters can count too since their CE signals are bounded together in cascade using terminals counts.</span></p>
<ul class="c24 lst-kix_s5ko05vmwr61-0">
   <li class="c3"><span class="c1">SAVE_FONTS_ROM_DATA</span></li>
</ul>
<p class="c8 c12"><span class="c0">Every time COUNTER_A reaches the end (TC_A = 1) the value of fonts_rom is stored in pixel_values_to_VGA. This is necessary because pixel values for character n are retrieved when character n-1 is displayed.</span></p>
<ul class="c24 lst-kix_s5ko05vmwr61-0">
   <li class="c3"><span class="c1">MEM_EDITOR_SIGNALS</span></li>
</ul>
<p class="c8 c12"><span class="c0">The function of this process is to make a copy of all signals that could change during the output of a frame stored in the frame buffer.</span></p>
<ul class="c24 lst-kix_s5ko05vmwr61-0">
   <li class="c3"><span class="c1">INV_COL</span></li>
</ul>
<p class="c8 c12"><span class="c0">This process checks if the current character is the one under the cursor, if so the next CHARACTER_WIDTH pixels will have the colours inverted. This is done with the help of a flag: invert_colors_MEM.</span></p>
<ul class="c24 lst-kix_s5ko05vmwr61-0">
   <li class="c3"><span class="c1">IMAGE_GEN</span></li>
</ul>
<p class="c8 c12"><span class="c23">Displays the values stored in pixels_value_to_VGA and if the inverted_clolors_MEM flag is on the colors are inverted.</span><span class="c0">&nbsp;</span></p>
<ul class="c24 lst-kix_s5ko05vmwr61-0">
   <li class="c3"><span class="c1">COUNT_A</span></li>
</ul>
<p class="c8 c12"><span class="c0">This counter keeps track of the horizontal position in a character. So its value changes from 0 to CHARACTER_WIDTH -1.</span></p>
<ul class="c24 lst-kix_s5ko05vmwr61-0">
   <li class="c3"><span class="c1">COUNT_AA</span></li>
</ul>
<p class="c8 c12"><span class="c0">This counter increases every time a character is completed, so its function is to track in which character column we are. This counter gets initialized at 1 and not 0 because during the display of character n we are requesting character n+1 so we are counting in advance for requesting to frame buffer the right values.</span></p>
<ul class="c24 lst-kix_s5ko05vmwr61-0">
   <li class="c3"><span class="c1">COUNT_B</span></li>
</ul>
<p class="c8 c12"><span class="c23">COUNTER_B counts the vertical position in a character. Every character is made of CHARACTER_HEIGHT*CHARACTER_WIDTH pixels, so in our project CHARACTER_WIDTH pixels is a character and every CHARACTER_HEIGHT characters, a character is printed</span><span class="c0">.</span></p>
<ul class="c24 lst-kix_s5ko05vmwr61-0">
   <li class="c3"><span class="c1">COUNT_BB</span></li>
</ul>
<p class="c8 c12"><span class="c0">The counterpart of COUNT_AA but counts in multiples of VERTICAL_CHARS (the max value of characters that fit in a line) this because this value is used to make requests to frame buffer.</span></p>
<h4 class="c20" id="h.x29x8o50avjl"><span class="c6">Combinational logic</span></h4>
<p class="c8"><span class="c0">The address sent to frame buffer is calculated by summing COUNTER_BB and COUNTER_AA. When frame buffer responds with a value this one is sent to fonts rom padded with the value of COUNTER_B (this value represents which character of a character we are printing)</span></p>
<h3 class="c7" id="h.36myif3jkmfo"><span class="c22 c18">Frame buffer</span></h3>
<h4 class="c20" id="h.7iy0zjwf9s5h"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">The frame buffer deals with the management of the frame to be printed on the screen. It contains BRAM_1 that is used to save a snapshot of a frame from stream and BRAM_2 that is used to synchronize the start scanning signal that comes from VGA_controller. In fact when there is a transition from &nbsp;0 to 1 of v_sync a process starts scanning and save the data from stream (BRAM_0) to frame buffer. Frame buffer stores ASCII int values and not pixels this makes less memory used. Since frame buffer is used with different clocks (master clk for write and pixel clk for read) use of a true dual port BRAM is necessary to overcome timing and clock phase problems.</span></p>
<h4 class="c20" id="h.9pxewspwovou"><span class="c6">Port description</span></h4>
<ul class="c24 lst-kix_8tfmatwi0beg-0 start">
   <li class="c3"><span class="c0">clk: master clock 100 MHz</span></li>
   <li class="c3"><span class="c0">clk_vga: pixel clock 25 MHz</span></li>
   <li class="c3"><span class="c0">resetn: general reset</span></li>
   <li class="c3"><span class="c0">vertical_sync: see v_sync from vga controller</span></li>
   <li class="c3"><span class="c0">stream_start_addr_for_scan: see frame_start_addr from editor</span></li>
   <li class="c3"><span class="c0">output_data_from_stream: see output_char_value from stream</span></li>
   <li class="c3"><span class="c0">addr_to_stream_for_data: is the address sent to stream where the next char to be saved is stored</span></li>
   <li class="c3"><span class="c0">addr_request_char: see address_for_frame_buffer_data from image generator</span></li>
   <li class="c3"><span class="c0">output_char_value: is the value returned after requesting data from address addr_request_char</span></li>
   <li class="c3"><span class="c0">is_writing: optional signal used for future components that signals busyness of frame buffer, if is_writing is on and read requests are made, data could be not in sync with the actual value stored</span></li>
</ul>
<h4 class="c20" id="h.15h2zui1ill8"><span class="c6">Processes</span></h4>
<ul class="c24 lst-kix_felocxufkiln-0 start">
   <li class="c3"><span class="c1">FSM_STARTER</span></li>
</ul>
<p class="c8 c12"><span>This process creates a pulse when senses a rising_edge in vertical_sync_mem, this pulse is assigned to start_pulse the signal responsible for starting the fsm. vertical_sync_mem is a signal in direct correlation with verical_sync but since the last one is out of sync with the master clk so sample of it must be taken.</span></p>
<ul class="c24 lst-kix_felocxufkiln-0">
   <li class="c3"><span class="c1">SEQUENTIAL, FUT_CALC, OUTPUTS</span></li>
</ul>
<p class="c8 c12"><span>This fsm switches between two states: wait and start, when in start state all subsequent processes are triggered else a sample of stream_start_address is taken for data consistency during stream scanning.</span></p>
<ul class="c24 lst-kix_felocxufkiln-0">
   <li class="c3"><span class="c1">MANAGE_EN_SIGNALS</span></li>
</ul>
<p class="c8 c12"><span>The only purpose of this process is to manage counter signals.</span></p>
<ul class="c24 lst-kix_felocxufkiln-0">
   <li class="c3"><span class="c1">ADDR_CALC</span></li>
</ul>
<p class="c8 c12"><span class="c0">This is a combinational process uses the value of counter and calculates address values for both stream requests and for storage in frame buffer itself. This process takes in count that output data from stream comes with 2 clocks delay. </span></p>
<ul class="c24 lst-kix_felocxufkiln-0">
   <li class="c3"><span class="c1">COUNTER</span></li>
</ul>
<p class="c8 c12"><span>Counts from NUMBER_OF_CHARS_IN_AFRAME times.</span></p>
<h3 class="c7" id="h.iyq2qdu6nld4"><span>Editor</span></h3>
<h4 class="c20" id="h.2k32ow89c4ex"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">Editor entity is used to manage:</span></p>
<ol class="c24 lst-kix_q4arf272syz1-0 start" start="1">
   <li class="c3"><span class="c0">Saving order if multiple keys are pressed at the same time.</span></li>
   <li class="c3"><span class="c0">Cursor position.</span></li>
   <li class="c3"><span class="c0">Special keys like arrows, backspace and enter.</span></li>
   <li class="c3"><span class="c0">Blinking of cursor timing.</span></li>
</ol>
<h4 class="c20" id="h.wrav6qh9iqn"><span>Fsm description</span><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 596.50px; height: 463.63px;"><img alt="" src="images/image13.png" style="width: 596.50px; height: 463.63px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></h4>
<p class="c8"><span class="c0">Variable “x” goes from 1 to 5 and represents multiple key digit.</span></p>
<h4 class="c20" id="h.5hehbjuq38j1"><span class="c6">Port description</span></h4>
<ul class="c24 lst-kix_kobez5puz6jw-0 start">
   <li class="c3"><span class="c0">sys_clk : system clock</span></li>
   <li class="c3"><span class="c0">resetn : reset active low</span></li>
   <li class="c3"><span class="c0">keyboard_digit_1 … 5 : keyboard digit (5 lines) from top_level_keyboard</span></li>
   <li class="c3"><span class="c0">cursor_pos_abs : absolute cursor potition</span></li>
   <li class="c3"><span class="c0">cursor_rel_pos : cursor position relative to the page printed</span></li>
   <li class="c3"><span class="c0">frame_start_addr : address of frame first position</span></li>
   <li class="c3"><span class="c0">char_to_write : char to send into stream</span></li>
   <li class="c3"><span class="c0">cursor_blinking_time : cursor blinking port </span></li>
</ul>
<h3 class="c7" id="h.mzo0sjrxk92m"><span class="c22 c18">Top level keyboard</span></h3>
<h4 class="c20" id="h.dyaqqjjjbfgj"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">His task is to connect all keyboard entity, i.e. fsm_keyboard and keyboard_driver.</span></p>
<p class="c8"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 388.00px;"><img alt="" src="images/image10.png" style="width: 624.00px; height: 388.00px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<p class="c8"><span class="c0">In the upper diagram is shown how fsm_keyboard and driver_keyboard are linked together and with top_level_keyboard. Others tasks of this entity are the conversion from keyboard key format at ASCII format, the management of shift key and of caps lock.</span></p>
<h4 class="c20" id="h.rmbum8jt8rop"><span class="c6">Port description</span></h4>
<ul class="c24 lst-kix_71fxcqm735xl-0 start">
   <li class="c3"><span class="c0">PS2_DATA : PS2 data line.</span></li>
   <li class="c3"><span class="c0">PS2_CLK : PS2 clock line.</span></li>
   <li class="c3"><span class="c0">clock : system clock.</span></li>
   <li class="c3"><span class="c0">reset : reset active low.</span></li>
   <li class="c3"><span class="c0">keyboard_digit_1 … 5 : are the signal that indicate which key is pressed. Up to 5 keys could be pressed at the same time. Data are in ASCII format.</span></li>
   <li class="c3"><span class="c0">CA, CB, CC, CD, CE, CF, CG, DP : cathodes for 7 segment display.</span></li>
   <li class="c3"><span class="c0">AN : anode for 7 segment display.0</span></li>
</ul>
<p class="c8 c19"><span class="c0"></span></p>
<h3 class="c7" id="h.sbirudkk4fy4"><span class="c22 c18">VGA controller</span></h3>
<h4 class="c20" id="h.1gf5vdqcsifq"><span class="c6">General description </span></h4>
<p class="c8"><span class="c23">This entity handles the VGA synchronization signals</span><span class="c0">&nbsp;for a 640x480 @ 60Hz monitor.</span></p>
<h4 class="c20" id="h.3tfi7j1kta05"><span class="c6">Port description</span></h4>
<ul class="c24 lst-kix_dgr7osbsaqrl-0 start">
   <li class="c3"><span class="c0">pixel_clk: vga clock that depends on the resolution of the display and framerate</span></li>
   <li class="c3"><span class="c0">res: master reset signal</span></li>
   <li class="c3"><span class="c0">h_sync: horizontal sync</span></li>
   <li class="c3"><span class="c0">v_sync: vertical sync</span></li>
   <li class="c3"><span class="c0">disp_en: display enable (screen time) </span></li>
   <li class="c3"><span class="c0">horizontal_active: on when not in either back porch, sync pulse or front porch horizontal</span></li>
   <li class="c3"><span class="c0">vertical_active: on when not in either back porch, sync pulse or front porch vertical</span></li>
</ul>
<h3 class="c7" id="h.5rj2yhek1o8z"><span class="c22 c18">Fonts ROM</span></h3>
<h4 class="c20" id="h.rddv2n3biumx"><span class="c6">General description </span></h4>
<p class="c8"><span class="c0">Fonts ROM contains all bits that compose the 128 character. Each font is made of 8 bits for width and 16 for height. The process that gives you the data is synchronous. Every address of this fonts rom represents a CHARACTER that is a line of pixels that composes a entire CHARACTER. A character is made of 16 characters.</span></p>
<h4 class="c20" id="h.szidgw1s2u73"><span class="c6">Port description</span></h4>
<ul class="c24 lst-kix_y115z15xz6v-0 start">
   <li class="c3"><span class="c0">clk: &nbsp;master clock at 25 Mhz (pixel_clock)</span></li>
   <li class="c3"><span class="c0">addr: &nbsp;see address_for_fonts_rom_data of image generator</span></li>
   <li class="c3"><span class="c0">data_out: is the 8 bit vector value that represents a character of a character</span></li>
</ul>
<h3 class="c7" id="h.ktojc5uwi11"><span class="c22 c18">Stream</span></h3>
<h4 class="c20" id="h.spwvkpza1zx6"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">Stream takes care of managing the writing and reading procedure from BRAM.</span></p>
<p class="c8"><span class="c0">Stream is composed by 2 process; writing_into_BRAM and save_char_val that manage the relative tasks. See the code for more information.</span></p>
<p class="c8"><span class="c0">The entity has the following ports.</span></p>
<h3 class="c21" id="h.e7hbn6toolhl"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 260.20px; height: 276.88px;"><img alt="" src="images/image5.png" style="width: 260.20px; height: 276.88px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></h3>
<h4 class="c20" id="h.3mis7j33on4i"><span class="c6">Port description</span></h4>
<ul class="c24 lst-kix_vw3m5orrbch-0 start">
   <li class="c3"><span class="c0">sys_clk : it’s the system clock.</span></li>
   <li class="c3"><span class="c0">resetn : it’s the reset port, active low.</span></li>
   <li class="c3"><span class="c0">input_char_value : This port is used to save data into BRAM. The procedure for saving datas are the following:</span></li>
</ul>
<p class="c8 c44"><span class="c0">Input_char_value must be for default at 0, then when there is a change on the port, data will be saved into BRAM in 1 clock cycle. It’s a asynchronous process so the port must be stable for minimum 1 clock cycle. Until the port doesn’t change value only one data is saved. To save two consecutive equal data input_char_value must goes to 0 for one clock cycle and then must be set again with the desired value. When the port is 0 no data are saved. </span></p>
<ul class="c24 lst-kix_rmj1f71wynm-0 start">
   <li class="c3"><span class="c0">requested_char_add : It’s used to set request char address.</span></li>
   <li class="c3"><span class="c0">set_cursor_pos : It’s used to change cursor position.</span></li>
   <li class="c3"><span class="c0">output_char_value : If new data is requested, after 2 clock cycles will be available on this port.</span></li>
</ul>
<p class="c8 c19"><span class="c0"></span></p>
<h3 class="c7" id="h.brfb7y9sm3us"><span class="c22 c18">Clock wizard</span></h3>
<h4 class="c20" id="h.bekf9t145y5v"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">Clock wizard is internal IP of Vivado that allow to manage the clock. In this project is used in MMCP mode to generate clock for VGA at 25 MHz (optimal would be at 25.175 MHz).</span></p>
<p class="c8"><span class="c0">The summary of clock wizard is shown in the figure below. </span></p>
<p class="c8"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 236.00px;"><img alt="" src="images/image3.jpg" style="width: 624.00px; height: 236.00px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<h4 class="c20" id="h.4sgqbbhaytf8"><span class="c6">Port description</span></h4>
<ul class="c24 lst-kix_agexjr8persv-0 start">
   <li class="c3"><span class="c0">clk_in : connected with system clock at 100 MHz.</span></li>
   <li class="c3"><span class="c0">resetn : reset active low.</span></li>
   <li class="c3"><span class="c0">clk_VGA : output clock for VGA management.</span></li>
</ul>
<h3 class="c7" id="h.qz2zcm94q1er"><span class="c22 c18">BRAM_0</span></h3>
<h4 class="c20" id="h.rol3obkaii5l"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">BRAM_0, that stay for Block of RAM is the entity that contains RAM memory. It’s generated by internally Vivado IP, therefore some specifications are protected by copyright and cannot be published.</span></p>
<p class="c8"><span class="c0">The entity has the following ports.</span></p>
<p class="c16"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 242.50px; height: 365.71px;"><img alt="" src="images/image2.png" style="width: 242.50px; height: 365.71px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<p class="c8"><span class="c0">The memory type is TRUE DUAL PORT RAM that means that there there are two different ports which could access at the same data also at the same time. In this project the PORTA is used to write into BRAM and PORTB is used to read. Write width is of 7 bits and the write depth is of 168000 bits. Since one character occupies 7 bits the stream could contain up to 24000 chars.</span></p>
<p class="c8"><span class="c0">The following image rappreset BRAM summary.</span></p>
<p class="c16"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 397.30px; height: 145.02px;"><img alt="" src="images/image12.jpg" style="width: 397.30px; height: 145.02px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<h4 class="c20" id="h.wrmgkju6gas1"><span class="c6">Port description</span></h4>
<ul class="c24 lst-kix_vtuvcc6l6kaa-0 start">
   <li class="c3"><span class="c0">clka, clkb : Are connected to the system clock.</span></li>
   <li class="c3"><span class="c0">rsta, rstb : Are connected to reset (active low).</span></li>
   <li class="c3"><span class="c0">ena, enb : Are used to enable the respective port.</span></li>
   <li class="c3"><span class="c0">wea, web : If hight port is in writing mode, else in reading.</span></li>
   <li class="c3"><span class="c0">addra, addrb : Indicate the port address.</span></li>
   <li class="c3"><span class="c0">dina, dinb : Are the data input ports.</span></li>
   <li class="c3"><span class="c0">douta, doutb : Are the data output ports. &nbsp;</span></li>
   <li class="c3"><span class="c0">rsta_busy, rstb_busy : Are not used ports.</span></li>
</ul>
<p class="c16 c19"><span class="c0"></span></p>
<h3 class="c7" id="h.aft3ls9mwyn"><span class="c22 c18">BRAM_1</span></h3>
<h4 class="c20" id="h.2hm8sd3jrkhs"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">This BRAM is used to storage the current frame values, so it contains 680 x 480 = 2400 data. It is used in simple dual port RAM mode because the writing clock is at 100MHz and the reading clock is at 25.175 MHz, therefore it also performs a work of connection and synchronization between the two circuits with different clocks.</span></p>
<p class="c16"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 471.63px; height: 171.50px;"><img alt="" src="images/image16.png" style="width: 471.63px; height: 171.50px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<h3 class="c7" id="h.b22xxw599ann"><span class="c22 c18">BRAM_2</span></h3>
<h4 class="c20" id="h.737szcxkxgzs"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">This BRAM is used only to synchronize a signal that is read at 100MHz and write at 25.175 MHz. The size is the smallest possible, in fact it’s of 2 bits and only one is used. The BRAM is always turned on and the delay from the input to the output is of 3 clock cycles, this because if the input signal change exactly during the rising edge of the clock the flip flop could go to metastability status and it would take some clock cycles to get back to normal.</span></p>
<p class="c16"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 516.50px; height: 178.16px;"><img alt="" src="images/image7.png" style="width: 516.50px; height: 178.16px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<p class="c8"><span class="c0">Sipo</span></p>
<h4 class="c20" id="h.mqvatvlrq1ks"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">Sipo is the acronym of Serial Input Parallel Output, in fact this entity works as register. It takes serial data from PS2_DATA line which comes from keyboard. Keyboard PS2 protocol use 11-bit words that include a start bit (0), data byte (LSB first), odd parity, and stop bit (1). When all data arrives data_ready signal in set and you can read data from parallel_output signals, then you must reset sipo. </span></p>
<p class="c16"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 242.00px; height: 222.00px;"><img alt="" src="images/image1.png" style="width: 242.00px; height: 222.00px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<h4 class="c20" id="h.8wkr24rcq9ae"><span class="c6">Port description</span></h4>
<ul class="c24 lst-kix_gr177dn0ml8l-0 start">
   <li class="c3"><span class="c0">PS2_DATA : PS2 data line.</span></li>
   <li class="c3"><span class="c0">PS2_CLK : PS2 clock line.</span></li>
   <li class="c3"><span class="c0">init_sipo : if low reset to 0 the register.</span></li>
   <li class="c3"><span class="c0">data_coming : is high when data are coming from PS2_DATA port.</span></li>
   <li class="c3"><span class="c0">data_ready : is set when all 11 bits are arrived.</span></li>
   <li class="c3"><span class="c0">parallel_output : parallel data output.</span></li>
</ul>
<h3 class="c7 c38" id="h.wo5v32v5oj1r"><span class="c22 c18"></span></h3>
<h3 class="c7" id="h.lic00sf26qiu"><span class="c22 c18">Keyboard driver</span></h3>
<h4 class="c20" id="h.gpx64ac6vqee"><span class="c6">General description</span></h4>
<p class="c8"><span class="c0">Keyboard driver entity has the task of managing the sipo entity, in particular there is a fsm that takes care of it. The following image represents the specifics of fsm. &nbsp;</span></p>
<p class="c16"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 327.11px; height: 618.50px;"><img alt="" src="images/image6.png" style="width: 327.11px; height: 618.50px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<h4 class="c20" id="h.ouiet278sgkk"><span class="c6">Fsm description</span></h4>
<ul class="c24 lst-kix_vslmbl7oon8k-0 start">
   <li class="c3"><span class="c0">wait_state : In this state sipo initialization sipo is done. The state doesn’t change until port “data_coming” is set.</span></li>
   <li class="c3"><span class="c0">start_watch_dog : In this state a watchdog counter stars and is increased. The state change only if data from sipo has arrived or if watchdog counter reaches 50ms. In this case there was an error because the data took too long to arrive.</span></li>
   <li class="c3"><span class="c0">load_data : makes data available from “data_out” ports and set new_data signal.</span></li>
   <li class="c3"><span class="c0">reset_state : reset the sipo, the watchdog counter and new_data signal.</span></li>
</ul>
<h4 class="c20" id="h.us5pwshrw8om"><span class="c6">Port description</span></h4>
<ul class="c24 lst-kix_kzc6cg2z1vsr-0 start">
   <li class="c3"><span class="c0">PS2_DATA : PS2 data line.</span></li>
   <li class="c3"><span class="c0">PS2_CLK : PS2 clock line.</span></li>
   <li class="c3"><span class="c0">clock : It’s connected with the system clock.</span></li>
   <li class="c3"><span class="c0">global_reset : It’s connected with the reset signal, active low.</span></li>
   <li class="c3"><span class="c0">data_out : It’s the data out port.</span></li>
   <li class="c3"><span class="c0">new_data : Indicates that new data arrived. It’s set for one clock cycle only.</span></li>
</ul>
<h3 class="c7" id="h.s4wq6u9492lr"><span class="c22 c18">Seven segment driver</span></h3>
<h4 class="c20" id="h.lm6rximc2bb"><span class="c6">General description </span></h4>
<p class="c8"><span class="c0">This entity drives 7 segment display that print the ASCII code of keyboard pressed keys</span></p>
<p class="c8 c19"><span class="c0"></span></p>
<h2 class="c34" id="h.hyflbz9fresj"><span class="c9">Power summary</span></h2>
<p class="c8"><span class="c0">The graphics below indicates the power consumptions setting.</span></p>
<p class="c16"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 264.00px;"><img alt="" src="images/image4.png" style="width: 624.00px; height: 264.00px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<p class="c8"><span class="c0">These settings produced the following results.</span></p>
<h2 class="c34" id="h.vuab15t4rtfc"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 230.67px;"><img alt="" src="images/image9.png" style="width: 624.00px; height: 230.67px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></h2>
<h2 class="c34" id="h.cum3h7fekrvv"><span class="c9">Implementation specifics</span></h2>
<p class="c8"><span class="c0">The following images represents the internal occupation on FPGA.</span></p>
<p class="c16"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 303.06px; height: 485.50px;"><img alt="" src="images/image15.png" style="width: 303.06px; height: 485.50px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></p>
<h1 class="c37" id="h.926dmker575g"><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 492.00px; height: 322.22px;"><img alt="" src="images/image11.png" style="width: 492.00px; height: 322.22px; margin-left: 0.00px; margin-top: 0.00px; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px);" title=""></span></h1>
<p class="c8"><span class="c0">Total lookup table = 867</span></p>
<p class="c8"><span class="c0">Total Flip Flop = 386</span></p>
<p class="c8"><span class="c0">Total BRAMs = 7.5</span></p>
<p class="c8"><span class="c0">Total URAM = 0</span></p>
<p class="c8"><span class="c0">Total DSP count = 0</span></p>
<p class="c8"><span class="c23">Worst negative slack &nbsp;= </span><span>2.937</span><span class="c0">&nbsp;ns</span></p>
<p class="c8"><span class="c23">Total negative slack = </span><span>0 </span><span class="c0">ns</span></p>
<p class="c8"><span class="c0">Worst hold slack = 0.14 ns</span></p>
<p class="c8"><span class="c0">Total hold slack = 0 ns</span></p>
<p class="c8"><span class="c0">Worst pulse width slack = 3 ns</span></p>
<p class="c8"><span class="c0">Total pulse width negative slack = 0 ns</span></p>
<h1 class="c31" id="h.hja5w8vnzs8c"><span class="c25 c27">Critical issues and conclusions</span></h1>
<h4 class="c20" id="h.c9nn2tr474gv"><span class="c6">Conclusions</span></h4>
<p class="c8"><span class="c23">The program works correctly! In a future</span><span class="c0">&nbsp;implementation/feature embedded monitor data will be taken in consideration such that the program is dynamic in regards of which max resolution the monitor can handle and could be displayed by the program.<br></span></p>

