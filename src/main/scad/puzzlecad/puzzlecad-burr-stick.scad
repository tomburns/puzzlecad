// Creates a burr_info struct given a Kaenel number.
    
function burr_stick(kaenel_number, stick_length = 6, add_stamp = false) =
    let (unstamped_burr_info =
        wrap(zyx_to_xyz(
            [ for (layer = kaenel_number_to_burr_info(kaenel_number))
                [ for (row = layer)
                    concat(copies((stick_length - 4) / 2, 1), row, copies((stick_length - 4) / 2, 1))
                ]
            ]
        ))
    )
    add_stamp ? add_burr_stick_stamp(unstamped_burr_info, str(kaenel_number)) : unstamped_burr_info;

// Converts a Kaenel number to a three-dimensional bit vector. The bit vector follows the standard
// definition of Kaenel number "carve-outs". For discussion, see:
// http://robspuzzlepage.com/interlocking.htm#identifying

function kaenel_number_to_burr_info(kaenel_number) =
    let (bitmask = kaenel_number - 1)
    [
      [[1                     , 1 - bit_of(bitmask,  8), 1 - bit_of(bitmask,  9), 1,                    ],
       [1                     , 1 - bit_of(bitmask, 10), 1 - bit_of(bitmask, 11), 1,                    ]],
      [[1 - bit_of(bitmask, 0), 1 - bit_of(bitmask,  1), 1 - bit_of(bitmask,  2), 1 - bit_of(bitmask, 3)],
       [1 - bit_of(bitmask, 4), 1 - bit_of(bitmask,  5), 1 - bit_of(bitmask,  6), 1 - bit_of(bitmask, 7)]]
    ];

// Stamps the end of a burr stick, inserting a label at the appropriate place in a burr_info struct.

function add_burr_stick_stamp(burr_info, stamp) =
    replace_in_array(burr_info, [0, 0, 0], [1, [
        ["label_text", stamp],
        ["label_orient", "x-y-"],
        ["label_hoffset", "-0.5"],
        ["label_voffset", "0.5"],
        ["label_scale", "0.538"]        // The curious constant 0.538 is for backward compatibility
    ]]);

module burr_stick_plate(ids, stick_length = 6) {

    page = [ for (id = ids)
        [id, opt_split(add_kaenel_number(burr_stick(ids[n], stick_length), ids[n]), auto_joint_letters[n - first_index])]
    ];
    labels = [for (pieces = page, n = [0:len(pieces[1])-1]) n == 0 ? str(pieces[0]) : undef];
    sticks = [for (pieces = page, piece = pieces[1]) piece];
    burr_plate(sticks, $burr_inset = inset, $burr_bevel = 0.5, $burr_outer_x_bevel = 1.75);
    
}

// Logic for custom-splitting a burr stick into printable components. Unlike puzzlecad's
// $auto_layout capability, this will preserve the ends of the stick to ensure a clean
// appearance.

function opt_split_burr_stick(stick, joint_label = " ") =
    is_simply_printable(stick) ? [stick] : [lower_split(stick, joint_label), upper_split(stick, joint_label)];

function is_simply_printable(stick, x = 0, y = 0) =
    y == len(stick[0]) ? true :
    x == len(stick) ? is_simply_printable(stick, 0, y + 1) :
    (stick[x][y][1][0] == 0 || stick[x][y][0][0] > 0) && is_simply_printable(stick, x + 1, y);

function lower_split(stick, joint_label) =
    [ for (x = [0:len(stick)-1])
        [ for (y = [0:1])
            [ for (z = [0:1])
                z == 0 && x > 0 && x < len(stick) - 1 ? (stick[x][y][z][0] == 1 && stick[x][y][1][0] == 1 ? [1, [["connect", "mz+y+"], ["clabel", joint_label]]] : stick[x][y][z]) :
                x >= (len(stick) - 4) / 2 && x < (len(stick) + 4) / 2 ? 0 : stick[x][y][z]
            ]
        ]
    ];
            
function upper_split(stick, joint_label) =
    [ for (x = [0:len(stick)-1])
        [ for (y = [0:1])
            x >= (len(stick) - 4) / 2 && x < (len(stick) + 4) / 2 ?
                (stick[x][y][0][0] == 1 && stick[x][y][1][0] == 1 ? [[1, [["connect", "fz-y+"], ["clabel", joint_label]]]] :
                        [stick[x][y][1]])
            : [[0]]
        ]
    ];